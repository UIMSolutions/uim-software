module uim.platform.ppm.presentation.http.controllers.resource_request;

import std.conv : to;
import uim.platform.ppm;

@safe:

class ResourceRequestController : SAPController {
    private ManageResourceRequestsUseCase useCase;

    this(ManageResourceRequestsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ppm/resource-requests", &handleList);
        router.get("/api/v1/ppm/resource-requests/*", &handleGet);
        router.post("/api/v1/ppm/resource-requests", &handleCreate);
        router.put("/api/v1/ppm/resource-requests/*", &handleUpdate);
        router.delete_("/api/v1/ppm/resource-requests/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= resourceRequestToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Resource request not found"); return; }
        writeJsonBody(res, resourceRequestToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ResourceRequestDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.projectId = jsonStr(j, "projectId");
        dto.role = jsonStr(j, "role");
        dto.quantity = jsonStr(j, "quantity");
        dto.allocationPercent = jsonStr(j, "allocationPercent");
        dto.startDate = jsonStr(j, "startDate");
        dto.endDate = jsonStr(j, "endDate");
        dto.status = jsonStr(j, "status");
        dto.requestedBy = jsonStr(j, "requestedBy");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ResourceRequestDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.projectId = jsonStr(j, "projectId");
        dto.role = jsonStr(j, "role");
        dto.quantity = jsonStr(j, "quantity");
        dto.allocationPercent = jsonStr(j, "allocationPercent");
        dto.startDate = jsonStr(j, "startDate");
        dto.endDate = jsonStr(j, "endDate");
        dto.status = jsonStr(j, "status");
        dto.requestedBy = jsonStr(j, "requestedBy");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
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
