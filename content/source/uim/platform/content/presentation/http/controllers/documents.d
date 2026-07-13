module uim.platform.content.presentation.http.controllers.documents;

import std.conv : to;
import uim.platform.content;

@safe:

class DocumentController : SAPController {
    private ManageDocumentsUseCase useCase;

    this(ManageDocumentsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/content/documents", &handleList);
        router.get("/api/v1/content/documents/*", &handleGet);
        router.post("/api/v1/content/documents", &handleCreate);
        router.put("/api/v1/content/documents/*", &handleUpdate);
        router.delete_("/api/v1/content/documents/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= documentToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Document not found");
            return;
        }
        res.writeJsonBody(documentToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        DocumentDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.repositoryId = jsonStr(j, "repositoryId");
        dto.folderId = jsonStr(j, "folderId");
        dto.title = jsonStr(j, "title");
        dto.documentNumber = jsonStr(j, "documentNumber");
        dto.objectType = jsonStr(j, "objectType");
        dto.mimeType = jsonStr(j, "mimeType");
        dto.fileName = jsonStr(j, "fileName");
        dto.fileSize = jsonStr(j, "fileSize");
        dto.checksum = jsonStr(j, "checksum");
        dto.storageUri = jsonStr(j, "storageUri");
        dto.status = jsonStr(j, "status");
        dto.classification = jsonStr(j, "classification");
        dto.tags = jsonStr(j, "tags");
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

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        DocumentDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.repositoryId = jsonStr(j, "repositoryId");
        dto.folderId = jsonStr(j, "folderId");
        dto.title = jsonStr(j, "title");
        dto.documentNumber = jsonStr(j, "documentNumber");
        dto.objectType = jsonStr(j, "objectType");
        dto.mimeType = jsonStr(j, "mimeType");
        dto.fileName = jsonStr(j, "fileName");
        dto.fileSize = jsonStr(j, "fileSize");
        dto.checksum = jsonStr(j, "checksum");
        dto.storageUri = jsonStr(j, "storageUri");
        dto.status = jsonStr(j, "status");
        dto.classification = jsonStr(j, "classification");
        dto.tags = jsonStr(j, "tags");
        dto.modifiedBy = jsonStr(j, "modifiedBy");

        auto result = useCase.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 200);
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
