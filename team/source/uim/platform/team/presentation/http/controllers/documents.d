module uim.platform.team.presentation.http.controllers.documents;

import std.conv : to;
import uim.platform.team;

@safe:

class DocumentsController : SAPController {
    private ManageDocumentsUseCase useCase;

    this(ManageDocumentsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/team/documents", &handleList);
        router.get("/api/v1/team/documents/*", &handleGet);
        router.post("/api/v1/team/documents", &handleCreate);
        router.put("/api/v1/team/documents/*", &handleUpdate);
        router.delete_("/api/v1/team/documents/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.listByTenant(req.headers.get("X-Tenant-Id", ""));
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= documentToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Document not found"); return; }
        writeJsonBody(res, documentToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        DocumentDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.title = jsonStr(j, "title");
        dto.docNumber = jsonStr(j, "docNumber");
        dto.revision = jsonStr(j, "revision");
        dto.docType = jsonStr(j, "docType");
        dto.fileName = jsonStr(j, "fileName");
        dto.fileUri = jsonStr(j, "fileUri");
        dto.relatedPartId = jsonStr(j, "relatedPartId");
        dto.relatedChangeId = jsonStr(j, "relatedChangeId");
        dto.owner = jsonStr(j, "owner");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");

        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        DocumentDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.title = jsonStr(j, "title");
        dto.docNumber = jsonStr(j, "docNumber");
        dto.revision = jsonStr(j, "revision");
        dto.docType = jsonStr(j, "docType");
        dto.fileName = jsonStr(j, "fileName");
        dto.fileUri = jsonStr(j, "fileUri");
        dto.relatedPartId = jsonStr(j, "relatedPartId");
        dto.relatedChangeId = jsonStr(j, "relatedChangeId");
        dto.owner = jsonStr(j, "owner");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");

        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.noContent;
        res.writeBody("");
    }
}
