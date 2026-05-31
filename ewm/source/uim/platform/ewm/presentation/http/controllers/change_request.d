module uim.platform.ewm.presentation.http.controllers.change_request;

import std.conv : to;
import uim.platform.ewm;

@safe:

class ChangeRequestController : SAPController {
    private ManageChangeRequestsUseCase useCase;
    this(ManageChangeRequestsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ewm/warehouse-tasks", &handleList);
        router.get("/api/v1/ewm/warehouse-tasks/*", &handleGet);
        router.post("/api/v1/ewm/warehouse-tasks", &handleCreate);
        router.put("/api/v1/ewm/warehouse-tasks/*", &handleUpdate);
        router.delete_("/api/v1/ewm/warehouse-tasks/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= changeRequestToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = useCase.get_(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Change request not found"); return; }
        writeJsonBody(res, changeRequestToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ChangeRequestDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.warehouseId = jsonStr(j, "warehouseId");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.priority = jsonStr(j, "priority");
        dto.status = jsonStr(j, "status");
        dto.reason = jsonStr(j, "reason");
        dto.impact = jsonStr(j, "impact");
        dto.requestedBy = jsonStr(j, "requestedBy");
        dto.assignedTo = jsonStr(j, "assignedTo");
        dto.approvedBy = jsonStr(j, "approvedBy");
        dto.affectedDocumentIds = jsonStr(j, "affectedDocumentIds");
        dto.affectedBomIds = jsonStr(j, "affectedBomIds");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ChangeRequestDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.priority = jsonStr(j, "priority");
        dto.status = jsonStr(j, "status");
        dto.reason = jsonStr(j, "reason");
        dto.impact = jsonStr(j, "impact");
        dto.requestedBy = jsonStr(j, "requestedBy");
        dto.assignedTo = jsonStr(j, "assignedTo");
        dto.approvedBy = jsonStr(j, "approvedBy");
        dto.affectedDocumentIds = jsonStr(j, "affectedDocumentIds");
        dto.affectedBomIds = jsonStr(j, "affectedBomIds");
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
