module uim.platform.mrp.presentation.http.controllers.bill_of_material;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class BillOfMaterialController : SAPController {
    private ManageBillsOfMaterialUseCase uc;

    this(ManageBillsOfMaterialUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/mrp/bills-of-material", &handleList);
        router.get("/api/v1/mrp/bills-of-material/*", &handleGet);
        router.post("/api/v1/mrp/bills-of-material", &handleCreate);
        router.put("/api/v1/mrp/bills-of-material/*", &handleUpdate);
        router.delete_("/api/v1/mrp/bills-of-material/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= billOfMaterialToJson(e);
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
            if (item is null) { writeError(res, 404, "Bill of material not found"); return; }
            res.writeJsonBody(billOfMaterialToJson(*item), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            BillOfMaterialDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.plantId = jsonStr(j, "plantId");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.parentMaterialId = jsonStr(j, "parentMaterialId");
            dto.componentMaterialId = jsonStr(j, "componentMaterialId");
            dto.componentQuantity = jsonStr(j, "componentQuantity");
            dto.baseQuantity = jsonStr(j, "baseQuantity");
            dto.scrapPercent = jsonStr(j, "scrapPercent");
            dto.validFrom = jsonStr(j, "validFrom");
            dto.validTo = jsonStr(j, "validTo");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Bill of material created");
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
            BillOfMaterialDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.componentQuantity = jsonStr(j, "componentQuantity");
            dto.baseQuantity = jsonStr(j, "baseQuantity");
            dto.scrapPercent = jsonStr(j, "scrapPercent");
            dto.validFrom = jsonStr(j, "validFrom");
            dto.validTo = jsonStr(j, "validTo");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Bill of material updated");
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
                resp["message"] = Json("Bill of material deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
