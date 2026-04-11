/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.presentation.http.controllers.purchase_order;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class PurchaseOrderController : SAPController {
    private ManagePurchaseOrdersUseCase uc;

    this(ManagePurchaseOrdersUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gtt/purchase-orders", &handleList);
        router.get("/api/v1/gtt/purchase-orders/*", &handleGet);
        router.post("/api/v1/gtt/purchase-orders", &handleCreate);
        router.put("/api/v1/gtt/purchase-orders/*", &handleUpdate);
        router.delete_("/api/v1/gtt/purchase-orders/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= purchaseOrderToJson(e);
            auto resp = Json.emptyObject;
            resp["count"] = Json(cast(long) items.length);
            resp["resources"] = jarr;
            res.writeJsonBody(resp, 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto path = req.requestURI.to!string;
            auto id = extractIdFromPath(path);
            auto e = uc.get_(id);
            if (e is null) { writeError(res, 404, "Purchase order not found"); return; }
            res.writeJsonBody(purchaseOrderToJson(*e), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            PurchaseOrderDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.orderNumber = jsonStr(j, "orderNumber");
            dto.supplierId = jsonStr(j, "supplierId");
            dto.buyerLocationId = jsonStr(j, "buyerLocationId");
            dto.supplierLocationId = jsonStr(j, "supplierLocationId");
            dto.items = jsonStr(j, "items");
            dto.orderDate = jsonStr(j, "orderDate");
            dto.expectedDeliveryDate = jsonStr(j, "expectedDeliveryDate");
            dto.currency = jsonStr(j, "currency");
            dto.totalAmount = jsonStr(j, "totalAmount");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Purchase order created");
                res.writeJsonBody(resp, 201);
            } else {
                writeError(res, 400, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto path = req.requestURI.to!string;
            auto j = req.json;
            PurchaseOrderDTO dto;
            dto.id = extractIdFromPath(path);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.actualDeliveryDate = jsonStr(j, "actualDeliveryDate");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Purchase order updated");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto path = req.requestURI.to!string;
            auto id = extractIdFromPath(path);
            auto result = uc.remove(id);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["message"] = Json("Purchase order deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
