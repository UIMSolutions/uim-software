module uim.platform.ps.presentation.http.controllers.network_activity;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class NetworkActivityController : SAPController {
    private ManageNetworkActivitiesUseCase uc;

    this(ManageNetworkActivitiesUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/ps/network-activities", &handleList);
        router.get("/api/v1/ps/network-activities/*", &handleGet);
        router.post("/api/v1/ps/network-activities", &handleCreate);
        router.put("/api/v1/ps/network-activities/*", &handleUpdate);
        router.delete_("/api/v1/ps/network-activities/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= networkActivityToJson(e);
            auto resp = Json.emptyObject;
            resp["count"] = Json(cast(long) items.length);
            resp["resources"] = jarr;
            res.writeJsonBody(resp, 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        import std.conv : to;
        try {
            auto id = extractIdFromPath(req.requestURI.to!string);
            auto item = uc.get_(id);
            if (item is null) { writeError(res, 404, "Network activity not found"); return; }
            res.writeJsonBody(networkActivityToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            NetworkActivityDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.projectId = jsonStr(j, "projectId");
            dto.wbsElementId = jsonStr(j, "wbsElementId");
            dto.activityNumber = jsonStr(j, "activityNumber");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.activityType = jsonStr(j, "activityType");
            dto.status = jsonStr(j, "status");
            dto.workCenter = jsonStr(j, "workCenter");
            dto.controlKey = jsonStr(j, "controlKey");
            dto.plannedWork = jsonStr(j, "plannedWork");
            dto.plannedStartDate = jsonStr(j, "plannedStartDate");
            dto.plannedFinishDate = jsonStr(j, "plannedFinishDate");
            dto.plannedCost = jsonStr(j, "plannedCost");
            dto.currency = jsonStr(j, "currency");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Network activity created");
                res.writeJsonBody(resp, 201);
            } else {
                writeError(res, 400, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        import std.conv : to;
        try {
            auto j = req.json;
            NetworkActivityDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.activityType = jsonStr(j, "activityType");
            dto.status = jsonStr(j, "status");
            dto.workCenter = jsonStr(j, "workCenter");
            dto.plannedWork = jsonStr(j, "plannedWork");
            dto.actualWork = jsonStr(j, "actualWork");
            dto.remainingWork = jsonStr(j, "remainingWork");
            dto.plannedStartDate = jsonStr(j, "plannedStartDate");
            dto.plannedFinishDate = jsonStr(j, "plannedFinishDate");
            dto.actualStartDate = jsonStr(j, "actualStartDate");
            dto.actualFinishDate = jsonStr(j, "actualFinishDate");
            dto.plannedCost = jsonStr(j, "plannedCost");
            dto.actualCost = jsonStr(j, "actualCost");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Network activity updated");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        import std.conv : to;
        try {
            auto id = extractIdFromPath(req.requestURI.to!string);
            auto result = uc.remove(id);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["message"] = Json("Network activity deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
