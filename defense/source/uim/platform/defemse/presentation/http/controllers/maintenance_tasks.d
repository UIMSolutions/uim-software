module uim.platform.defense.presentation.http.controllers.maintenance_tasks;

import std.conv : to;
import vibe.data.json : Json;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse, HTTPStatus;
import uim.platform.defense;

@safe:

class MaintenanceTaskController : SAPController {
    private ManageMaintenanceTasksUseCase useCase;

    this(ManageMaintenanceTasksUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/defense/maintenance-tasks", &listAll);
        router.get("/api/v1/defense/maintenance-tasks/*", &getOne);
        router.post("/api/v1/defense/maintenance-tasks", &create);
        router.put("/api/v1/defense/maintenance-tasks/*", &update);
        router.delete_("/api/v1/defense/maintenance-tasks/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= maintenanceTaskToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Maintenance task not found"); return; }
        writeJsonBody(res, maintenanceTaskToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) {
        auto j = req.json;
        MaintenanceTaskDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", jsonStr(j, "tenantId"));
        dto.contingentId = jsonStr(j, "contingentId");
        dto.equipmentId = jsonStr(j, "equipmentId");
        dto.taskType = jsonStr(j, "taskType");
        dto.priority = jsonStr(j, "priority");
        dto.dueAt = jsonStr(j, "dueAt");
        dto.status = jsonStr(j, "status");
        dto.locationId = jsonStr(j, "locationId");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void update(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto j = req.json;
        MaintenanceTaskDTO dto;
        dto.id = id;
        dto.contingentId = jsonStr(j, "contingentId");
        dto.equipmentId = jsonStr(j, "equipmentId");
        dto.taskType = jsonStr(j, "taskType");
        dto.priority = jsonStr(j, "priority");
        dto.dueAt = jsonStr(j, "dueAt");
        dto.status = jsonStr(j, "status");
        dto.locationId = jsonStr(j, "locationId");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void remove(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.noContent;
        res.writeBody("");
    }
}