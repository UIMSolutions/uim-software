module uim.platform.mii.presentation.http.controllers.document;

import std.conv : to;
import uim.platform.mii;

@safe:

class DocumentController : SAPController {
    private ManageDocumentsUseCase useCase;
    this(ManageDocumentsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/mii/kpi-observations", &handleList);
        router.get("/api/v1/mii/kpi-observations/*", &handleGet);
        router.post("/api/v1/mii/kpi-observations", &handleCreate);
        router.put("/api/v1/mii/kpi-observations/*", &handleUpdate);
        router.delete_("/api/v1/mii/kpi-observations/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= documentToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = useCase.get_(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Document not found"); return; }
        writeJsonBody(res, documentToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        DocumentDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.messageId = jsonStr(j, "messageId");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.documentType = jsonStr(j, "documentType");
        dto.status = jsonStr(j, "status");
        dto.documentNumber = jsonStr(j, "documentNumber");
        dto.fileName = jsonStr(j, "fileName");
        dto.mimeType = jsonStr(j, "mimeType");
        dto.language = jsonStr(j, "language");
        dto.author = jsonStr(j, "author");
        dto.approvedBy = jsonStr(j, "approvedBy");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        DocumentDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.documentType = jsonStr(j, "documentType");
        dto.status = jsonStr(j, "status");
        dto.documentNumber = jsonStr(j, "documentNumber");
        dto.fileName = jsonStr(j, "fileName");
        dto.mimeType = jsonStr(j, "mimeType");
        dto.language = jsonStr(j, "language");
        dto.author = jsonStr(j, "author");
        dto.approvedBy = jsonStr(j, "approvedBy");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = useCase.remove(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.noContent;
        res.writeBody("");
    }
}
