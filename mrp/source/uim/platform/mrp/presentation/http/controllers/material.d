module uim.platform.mrp.presentation.http.controllers.material;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class MaterialController : SAPController {
    private ManageMaterialsUseCase uc;

    this(ManageMaterialsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/mrp/materials", &handleList);
        router.get("/api/v1/mrp/materials/*", &handleGet);
        router.post("/api/v1/mrp/materials", &handleCreate);
        router.put("/api/v1/mrp/materials/*", &handleUpdate);
        router.delete_("/api/v1/mrp/materials/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= materialToJson(e);
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
            if (item is null) { writeError(res, 404, "Material not found"); return; }
            res.writeJsonBody(materialToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            MaterialDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.plantId = jsonStr(j, "plantId");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.materialNumber = jsonStr(j, "materialNumber");
            dto.baseUnit = jsonStr(j, "baseUnit");
            dto.mrpProcedure = jsonStr(j, "mrpProcedure");
            dto.lotSizingProcedure = jsonStr(j, "lotSizingProcedure");
            dto.procurementType = jsonStr(j, "procurementType");
            dto.status = jsonStr(j, "status");
            dto.safetyStock = jsonStr(j, "safetyStock");
            dto.reorderPoint = jsonStr(j, "reorderPoint");
            dto.lotSize = jsonStr(j, "lotSize");
            dto.minimumLotSize = jsonStr(j, "minimumLotSize");
            dto.independentDemand = jsonStr(j, "independentDemand");
            dto.planningTimeFenceDays = jsonStr(j, "planningTimeFenceDays");
            dto.inHouseProductionTimeDays = jsonStr(j, "inHouseProductionTimeDays");
            dto.plannedDeliveryTimeDays = jsonStr(j, "plannedDeliveryTimeDays");
            dto.grProcessingTimeDays = jsonStr(j, "grProcessingTimeDays");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Material created");
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
            MaterialDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.materialNumber = jsonStr(j, "materialNumber");
            dto.baseUnit = jsonStr(j, "baseUnit");
            dto.mrpProcedure = jsonStr(j, "mrpProcedure");
            dto.lotSizingProcedure = jsonStr(j, "lotSizingProcedure");
            dto.procurementType = jsonStr(j, "procurementType");
            dto.status = jsonStr(j, "status");
            dto.safetyStock = jsonStr(j, "safetyStock");
            dto.reorderPoint = jsonStr(j, "reorderPoint");
            dto.lotSize = jsonStr(j, "lotSize");
            dto.minimumLotSize = jsonStr(j, "minimumLotSize");
            dto.independentDemand = jsonStr(j, "independentDemand");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Material updated");
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
                resp["message"] = Json("Material deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
