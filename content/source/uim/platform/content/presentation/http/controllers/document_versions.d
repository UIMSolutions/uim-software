module uim.platform.content.presentation.http.controllers.document_versions;

import std.conv : to;
import uim.platform.content;

@safe:

class DocumentVersionController : SAPController {
    private ManageDocumentVersionsUseCase useCase;

    this(ManageDocumentVersionsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/content/documents/*/versions", &handleList);
        router.post("/api/v1/content/documents/*/versions", &handleCreate);
        router.get("/api/v1/content/document-versions/*", &handleGet);
        router.delete_("/api/v1/content/document-versions/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto documentId = extractIdFromPath(req.requestPath.to!string);
        auto items = useCase.listByDocumentId(documentId);
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= documentVersionToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["documentId"] = Json(documentId);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Document version not found");
            return;
        }
        res.writeJsonBody(documentVersionToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        auto documentId = extractIdFromPath(req.requestPath.to!string);

        DocumentVersionDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.documentId = documentId;
        dto.versionLabel = jsonStr(j, "versionLabel");
        dto.fileName = jsonStr(j, "fileName");
        dto.mimeType = jsonStr(j, "mimeType");
        dto.fileSize = jsonStr(j, "fileSize");
        dto.checksum = jsonStr(j, "checksum");
        dto.storageUri = jsonStr(j, "storageUri");
        dto.versionNote = jsonStr(j, "versionNote");
        dto.createdBy = jsonStr(j, "createdBy");

        auto result = useCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 201);
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        res.writeBody("", 204, "text/plain");
    }
}
