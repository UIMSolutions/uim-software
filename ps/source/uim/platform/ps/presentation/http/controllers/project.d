module uim.platform.ps.presentation.http.controllers.project;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class ProjectController : SAPController {
    private ManageProjectsUseCase uc;

    this(ManageProjectsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/ps/projects", &handleList);
        router.get("/api/v1/ps/projects/*", &handleGet);
        router.post("/api/v1/ps/projects", &handleCreate);
        router.put("/api/v1/ps/projects/*", &handleUpdate);
        router.delete_("/api/v1/ps/projects/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= projectToJson(e);
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
            if (item is null) { writeError(res, 404, "Project not found"); return; }
            res.writeJsonBody(projectToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ProjectDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.projectDefinition = jsonStr(j, "projectDefinition");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.projectType = jsonStr(j, "projectType");
            dto.status = jsonStr(j, "status");
            dto.companyCode = jsonStr(j, "companyCode");
            dto.controllingArea = jsonStr(j, "controllingArea");
            dto.profitCenter = jsonStr(j, "profitCenter");
            dto.responsiblePerson = jsonStr(j, "responsiblePerson");
            dto.projectManager = jsonStr(j, "projectManager");
            dto.plannedStartDate = jsonStr(j, "plannedStartDate");
            dto.plannedFinishDate = jsonStr(j, "plannedFinishDate");
            dto.billingType = jsonStr(j, "billingType");
            dto.currency = jsonStr(j, "currency");
            dto.totalBudget = jsonStr(j, "totalBudget");
            dto.projectProfile = jsonStr(j, "projectProfile");
            dto.budgetControlActive = jsonStr(j, "budgetControlActive");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Project created");
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
            ProjectDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.projectDefinition = jsonStr(j, "projectDefinition");
            dto.projectType = jsonStr(j, "projectType");
            dto.status = jsonStr(j, "status");
            dto.companyCode = jsonStr(j, "companyCode");
            dto.controllingArea = jsonStr(j, "controllingArea");
            dto.profitCenter = jsonStr(j, "profitCenter");
            dto.responsiblePerson = jsonStr(j, "responsiblePerson");
            dto.projectManager = jsonStr(j, "projectManager");
            dto.plannedStartDate = jsonStr(j, "plannedStartDate");
            dto.plannedFinishDate = jsonStr(j, "plannedFinishDate");
            dto.actualStartDate = jsonStr(j, "actualStartDate");
            dto.actualFinishDate = jsonStr(j, "actualFinishDate");
            dto.currency = jsonStr(j, "currency");
            dto.totalPlannedCost = jsonStr(j, "totalPlannedCost");
            dto.totalActualCost = jsonStr(j, "totalActualCost");
            dto.totalBudget = jsonStr(j, "totalBudget");
            dto.billingType = jsonStr(j, "billingType");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Project updated");
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
                resp["message"] = Json("Project deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
