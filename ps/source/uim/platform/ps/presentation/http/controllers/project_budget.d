module uim.platform.ps.presentation.http.controllers.project_budget;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class ProjectBudgetController : SAPController {
    private ManageProjectBudgetsUseCase uc;

    this(ManageProjectBudgetsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/ps/budgets", &handleList);
        router.get("/api/v1/ps/budgets/*", &handleGet);
        router.post("/api/v1/ps/budgets", &handleCreate);
        router.put("/api/v1/ps/budgets/*", &handleUpdate);
        router.delete_("/api/v1/ps/budgets/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= projectBudgetToJson(e);
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
            if (item is null) { writeError(res, 404, "Project budget not found"); return; }
            res.writeJsonBody(projectBudgetToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ProjectBudgetDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.projectId = jsonStr(j, "projectId");
            dto.wbsElementId = jsonStr(j, "wbsElementId");
            dto.budgetStatus = jsonStr(j, "budgetStatus");
            dto.originalBudget = jsonStr(j, "originalBudget");
            dto.currentBudget = jsonStr(j, "currentBudget");
            dto.supplementBudget = jsonStr(j, "supplementBudget");
            dto.returnBudget = jsonStr(j, "returnBudget");
            dto.transferBudget = jsonStr(j, "transferBudget");
            dto.availableBudget = jsonStr(j, "availableBudget");
            dto.assignedBudget = jsonStr(j, "assignedBudget");
            dto.currency = jsonStr(j, "currency");
            dto.fiscalYear = jsonStr(j, "fiscalYear");
            dto.validFrom = jsonStr(j, "validFrom");
            dto.validTo = jsonStr(j, "validTo");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Project budget created");
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
            ProjectBudgetDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.budgetStatus = jsonStr(j, "budgetStatus");
            dto.originalBudget = jsonStr(j, "originalBudget");
            dto.currentBudget = jsonStr(j, "currentBudget");
            dto.supplementBudget = jsonStr(j, "supplementBudget");
            dto.returnBudget = jsonStr(j, "returnBudget");
            dto.transferBudget = jsonStr(j, "transferBudget");
            dto.availableBudget = jsonStr(j, "availableBudget");
            dto.assignedBudget = jsonStr(j, "assignedBudget");
            dto.currency = jsonStr(j, "currency");
            dto.fiscalYear = jsonStr(j, "fiscalYear");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Project budget updated");
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
                resp["message"] = Json("Project budget deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
