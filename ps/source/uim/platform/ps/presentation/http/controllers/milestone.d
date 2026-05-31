module uim.platform.ps.presentation.http.controllers.milestone;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class MilestoneController : SAPController {
    private ManageMilestonesUseCase uc;

    this(ManageMilestonesUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/ps/milestones", &handleList);
        router.get("/api/v1/ps/milestones/*", &handleGet);
        router.post("/api/v1/ps/milestones", &handleCreate);
        router.put("/api/v1/ps/milestones/*", &handleUpdate);
        router.delete_("/api/v1/ps/milestones/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= milestoneToJson(e);
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
            if (item is null) { writeError(res, 404, "Milestone not found"); return; }
            res.writeJsonBody(milestoneToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            MilestoneDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.projectId = jsonStr(j, "projectId");
            dto.wbsElementId = jsonStr(j, "wbsElementId");
            dto.activityId = jsonStr(j, "activityId");
            dto.milestoneNumber = jsonStr(j, "milestoneNumber");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.category = jsonStr(j, "category");
            dto.isReached = jsonStr(j, "isReached");
            dto.plannedDate = jsonStr(j, "plannedDate");
            dto.actualDate = jsonStr(j, "actualDate");
            dto.billingAmount = jsonStr(j, "billingAmount");
            dto.currency = jsonStr(j, "currency");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Milestone created");
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
            MilestoneDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.category = jsonStr(j, "category");
            dto.isReached = jsonStr(j, "isReached");
            dto.plannedDate = jsonStr(j, "plannedDate");
            dto.actualDate = jsonStr(j, "actualDate");
            dto.billingAmount = jsonStr(j, "billingAmount");
            dto.currency = jsonStr(j, "currency");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Milestone updated");
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
                resp["message"] = Json("Milestone deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
