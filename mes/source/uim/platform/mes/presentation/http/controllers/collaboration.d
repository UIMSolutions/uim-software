module uim.platform.mes.presentation.http.controllers.collaboration;

import std.conv : to;
import uim.platform.mes;

@safe:

class CollaborationController : SAPController {
    private ManageCollaborationsUseCase useCase;
    this(ManageCollaborationsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/mes/operator-collaborations", &handleList);
        router.get("/api/v1/mes/operator-collaborations/*", &handleGet);
        router.post("/api/v1/mes/operator-collaborations", &handleCreate);
        router.put("/api/v1/mes/operator-collaborations/*", &handleUpdate);
        router.delete_("/api/v1/mes/operator-collaborations/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= collaborationToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = useCase.get_(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Collaboration not found"); return; }
        writeJsonBody(res, collaborationToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        CollaborationDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.orderId = jsonStr(j, "orderId");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.collaborationType = jsonStr(j, "collaborationType");
        dto.status = jsonStr(j, "status");
        dto.assignedTo = jsonStr(j, "assignedTo");
        dto.participants = jsonStr(j, "participants");
        dto.dueDate = jsonStr(j, "dueDate");
        dto.resolvedDate = jsonStr(j, "resolvedDate");
        dto.resolution = jsonStr(j, "resolution");
        dto.relatedDocumentId = jsonStr(j, "relatedDocumentId");
        dto.relatedChangeRequestId = jsonStr(j, "relatedChangeRequestId");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        CollaborationDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.collaborationType = jsonStr(j, "collaborationType");
        dto.status = jsonStr(j, "status");
        dto.assignedTo = jsonStr(j, "assignedTo");
        dto.participants = jsonStr(j, "participants");
        dto.dueDate = jsonStr(j, "dueDate");
        dto.resolvedDate = jsonStr(j, "resolvedDate");
        dto.resolution = jsonStr(j, "resolution");
        dto.relatedDocumentId = jsonStr(j, "relatedDocumentId");
        dto.relatedChangeRequestId = jsonStr(j, "relatedChangeRequestId");
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
