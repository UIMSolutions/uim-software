module uim.platform.ps.presentation.http.controllers.project_cost;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class ProjectCostController : SAPController {
    private ManageProjectCostsUseCase uc;

    this(ManageProjectCostsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/ps/costs", &handleList);
        router.get("/api/v1/ps/costs/*", &handleGet);
        router.post("/api/v1/ps/costs", &handleCreate);
        router.put("/api/v1/ps/costs/*", &handleUpdate);
        router.delete_("/api/v1/ps/costs/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= projectCostToJson(e);
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
            if (item is null) { writeError(res, 404, "Project cost not found"); return; }
            res.writeJsonBody(projectCostToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ProjectCostDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.projectId = jsonStr(j, "projectId");
            dto.wbsElementId = jsonStr(j, "wbsElementId");
            dto.activityId = jsonStr(j, "activityId");
            dto.costCategory = jsonStr(j, "costCategory");
            dto.costElement = jsonStr(j, "costElement");
            dto.plannedCost = jsonStr(j, "plannedCost");
            dto.actualCost = jsonStr(j, "actualCost");
            dto.committedCost = jsonStr(j, "committedCost");
            dto.remainingCost = jsonStr(j, "remainingCost");
            dto.currency = jsonStr(j, "currency");
            dto.fiscalYear = jsonStr(j, "fiscalYear");
            dto.period = jsonStr(j, "period");
            dto.postingDate = jsonStr(j, "postingDate");
            dto.documentNumber = jsonStr(j, "documentNumber");
            dto.description = jsonStr(j, "description");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Project cost created");
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
            ProjectCostDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.costCategory = jsonStr(j, "costCategory");
            dto.costElement = jsonStr(j, "costElement");
            dto.plannedCost = jsonStr(j, "plannedCost");
            dto.actualCost = jsonStr(j, "actualCost");
            dto.committedCost = jsonStr(j, "committedCost");
            dto.remainingCost = jsonStr(j, "remainingCost");
            dto.currency = jsonStr(j, "currency");
            dto.description = jsonStr(j, "description");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Project cost updated");
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
                resp["message"] = Json("Project cost deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
