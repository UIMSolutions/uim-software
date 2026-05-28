module uim.platform.mrp.presentation.http.controllers.mrp_run;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class MrpRunController : SAPController {
    private ManageMrpRunsUseCase uc;

    this(ManageMrpRunsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/mrp/runs", &handleList);
        router.get("/api/v1/mrp/runs/*", &handleGet);
        router.post("/api/v1/mrp/runs", &handleCreate);
        router.put("/api/v1/mrp/runs/*", &handleUpdate);
        router.delete_("/api/v1/mrp/runs/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= mrpRunToJson(e);
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
            if (item is null) { writeError(res, 404, "MRP run not found"); return; }
            res.writeJsonBody(mrpRunToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            MrpRunDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.plantId = jsonStr(j, "plantId");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.mode = jsonStr(j, "mode");
            dto.planningDate = jsonStr(j, "planningDate");
            dto.horizonDays = jsonStr(j, "horizonDays");
            dto.includeExternalRequirements = jsonStr(j, "includeExternalRequirements");
            dto.includeDependentRequirements = jsonStr(j, "includeDependentRequirements");
            dto.includeSafetyStock = jsonStr(j, "includeSafetyStock");
            dto.executedBy = jsonStr(j, "executedBy");
            dto.executedAt = jsonStr(j, "executedAt");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("MRP run executed and procurement proposals generated");
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
            MrpRunDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.status = jsonStr(j, "status");
            dto.modifiedAt = jsonStr(j, "modifiedAt");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("MRP run updated");
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
                resp["message"] = Json("MRP run deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
