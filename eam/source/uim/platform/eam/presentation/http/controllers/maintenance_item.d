/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.presentation.http.controllers.maintenance_item;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class MaintenanceItemController : SAPController {
    private ManageMaintenanceItemsUseCase uc;

    this(ManageMaintenanceItemsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/eam/maintenance-items", &handleList);
        router.get("/api/v1/eam/maintenance-items/*", &handleGet);
        router.post("/api/v1/eam/maintenance-items", &handleCreate);
        router.put("/api/v1/eam/maintenance-items/*", &handleUpdate);
        router.delete_("/api/v1/eam/maintenance-items/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= maintenanceItemToJson(e);
            auto resp = Json.emptyObject;
            resp["count"] = Json(cast(long) items.length);
            resp["resources"] = jarr;
            res.writeJsonBody(resp, 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto path = req.requestURI.to!string;
            auto id = extractIdFromPath(path);
            auto e = uc.get_(id);
            if (e is null) { writeError(res, 404, "Maintenance item not found"); return; }
            res.writeJsonBody(maintenanceItemToJson(*e), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            MaintenanceItemDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.maintenancePlanId = jsonStr(j, "maintenancePlanId");
            dto.equipmentId = jsonStr(j, "equipmentId");
            dto.functionalLocationId = jsonStr(j, "functionalLocationId");
            dto.taskListId = jsonStr(j, "taskListId");
            dto.taskListDescription = jsonStr(j, "taskListDescription");
            dto.workCenterId = jsonStr(j, "workCenterId");
            dto.orderType = jsonStr(j, "orderType");
            dto.cycle = jsonStr(j, "cycle");
            dto.cycleUnit = jsonStr(j, "cycleUnit");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Maintenance item created");
                res.writeJsonBody(resp, 201);
            } else {
                writeError(res, 400, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto path = req.requestURI.to!string;
            auto j = req.json;
            MaintenanceItemDTO dto;
            dto.id = extractIdFromPath(path);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.taskListId = jsonStr(j, "taskListId");
            dto.taskListDescription = jsonStr(j, "taskListDescription");
            dto.workCenterId = jsonStr(j, "workCenterId");
            dto.orderType = jsonStr(j, "orderType");
            dto.cycle = jsonStr(j, "cycle");
            dto.cycleUnit = jsonStr(j, "cycleUnit");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Maintenance item updated");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto path = req.requestURI.to!string;
            auto id = extractIdFromPath(path);
            auto result = uc.remove(id);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["message"] = Json("Maintenance item deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
