module uim.platform.mrp.presentation.http.controllers.procurement_proposal;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class ProcurementProposalController : SAPController {
    private ManageProcurementProposalsUseCase uc;

    this(ManageProcurementProposalsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/mrp/procurement-proposals", &handleList);
        router.get("/api/v1/mrp/procurement-proposals/*", &handleGet);
        router.post("/api/v1/mrp/procurement-proposals", &handleCreate);
        router.put("/api/v1/mrp/procurement-proposals/*", &handleUpdate);
        router.delete_("/api/v1/mrp/procurement-proposals/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= procurementProposalToJson(e);
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
            if (item is null) { writeError(res, 404, "Procurement proposal not found"); return; }
            res.writeJsonBody(procurementProposalToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ProcurementProposalDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.mrpRunId = jsonStr(j, "mrpRunId");
            dto.plantId = jsonStr(j, "plantId");
            dto.materialId = jsonStr(j, "materialId");
            dto.proposalType = jsonStr(j, "proposalType");
            dto.status = jsonStr(j, "status");
            dto.quantity = jsonStr(j, "quantity");
            dto.dueDate = jsonStr(j, "dueDate");
            dto.source = jsonStr(j, "source");
            dto.exceptionMessage = jsonStr(j, "exceptionMessage");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Procurement proposal created");
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
            ProcurementProposalDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.proposalType = jsonStr(j, "proposalType");
            dto.status = jsonStr(j, "status");
            dto.quantity = jsonStr(j, "quantity");
            dto.dueDate = jsonStr(j, "dueDate");
            dto.source = jsonStr(j, "source");
            dto.exceptionMessage = jsonStr(j, "exceptionMessage");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Procurement proposal updated");
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
                resp["message"] = Json("Procurement proposal deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
