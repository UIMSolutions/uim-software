module uim.platform.ps.presentation.http.controllers.wbs_element;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class WBSElementController : SAPController {
    private ManageWBSElementsUseCase uc;

    this(ManageWBSElementsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/ps/wbs-elements", &handleList);
        router.get("/api/v1/ps/wbs-elements/*", &handleGet);
        router.post("/api/v1/ps/wbs-elements", &handleCreate);
        router.put("/api/v1/ps/wbs-elements/*", &handleUpdate);
        router.delete_("/api/v1/ps/wbs-elements/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= wbsElementToJson(e);
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
            if (item is null) { writeError(res, 404, "WBS element not found"); return; }
            res.writeJsonBody(wbsElementToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WBSElementDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.projectId = jsonStr(j, "projectId");
            dto.parentId = jsonStr(j, "parentId");
            dto.wbsCode = jsonStr(j, "wbsCode");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.elementType = jsonStr(j, "elementType");
            dto.status = jsonStr(j, "status");
            dto.responsiblePerson = jsonStr(j, "responsiblePerson");
            dto.workCenter = jsonStr(j, "workCenter");
            dto.profitCenter = jsonStr(j, "profitCenter");
            dto.costCenter = jsonStr(j, "costCenter");
            dto.plannedStartDate = jsonStr(j, "plannedStartDate");
            dto.plannedFinishDate = jsonStr(j, "plannedFinishDate");
            dto.plannedCost = jsonStr(j, "plannedCost");
            dto.currency = jsonStr(j, "currency");
            dto.isAccountAssignment = jsonStr(j, "isAccountAssignment");
            dto.isPlanningElement = jsonStr(j, "isPlanningElement");
            dto.isBillingElement = jsonStr(j, "isBillingElement");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("WBS element created");
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
            WBSElementDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.wbsCode = jsonStr(j, "wbsCode");
            dto.elementType = jsonStr(j, "elementType");
            dto.status = jsonStr(j, "status");
            dto.responsiblePerson = jsonStr(j, "responsiblePerson");
            dto.workCenter = jsonStr(j, "workCenter");
            dto.plannedStartDate = jsonStr(j, "plannedStartDate");
            dto.plannedFinishDate = jsonStr(j, "plannedFinishDate");
            dto.plannedCost = jsonStr(j, "plannedCost");
            dto.actualCost = jsonStr(j, "actualCost");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("WBS element updated");
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
                resp["message"] = Json("WBS element deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
