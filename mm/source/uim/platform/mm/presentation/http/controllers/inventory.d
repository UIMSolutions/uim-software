module uim.platform.mm.presentation.http.controllers.inventory;

import std.conv : to;
import uim.platform.mm;

@safe:

class InventoryController : SAPController {
    private ManageInventoryUseCase inventory;

    this(ManageInventoryUseCase inventory) {
        this.inventory = inventory;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);

        router.get("/api/v1/mm/stock-items", &handleListStockItems);
        router.get("/api/v1/mm/stock-items/*", &handleGetStockItem);
        router.post("/api/v1/mm/stock-items", &handleCreateStockItem);
        router.put("/api/v1/mm/stock-items/*", &handleUpdateStockItem);
        router.delete_("/api/v1/mm/stock-items/*", &handleDeleteStockItem);

        router.get("/api/v1/mm/goods-receipts", &handleListGoodsReceipts);
        router.get("/api/v1/mm/goods-receipts/*", &handleGetGoodsReceipt);
        router.post("/api/v1/mm/goods-receipts", &handleCreateGoodsReceipt);
        router.delete_("/api/v1/mm/goods-receipts/*", &handleDeleteGoodsReceipt);
    }

    private void handleListStockItems(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeListResponse!StockItem(res, inventory.listStock(), &stockItemToJson);
    }

    private void handleGetStockItem(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = inventory.getStock(extractIdFromPath(req.requestURI.to!string));
        if (item is null) { writeError(res, 404, "Stock item not found"); return; }
        res.writeJsonBody(stockItemToJson(*item), 200);
    }

    private void handleCreateStockItem(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        StockItemDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.materialId = jsonStr(j, "materialId");
        dto.plantId = jsonStr(j, "plantId");
        dto.storageLocationId = jsonStr(j, "storageLocationId");
        dto.unrestrictedUseQty = jsonStr(j, "unrestrictedUseQty");
        dto.qualityInspectionQty = jsonStr(j, "qualityInspectionQty");
        dto.blockedQty = jsonStr(j, "blockedQty");
        dto.openInboundQty = jsonStr(j, "openInboundQty");
        dto.lastMovementAt = jsonStr(j, "lastMovementAt");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, inventory.createStockItem(dto), 201, "Stock item created", 400);
    }

    private void handleUpdateStockItem(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        StockItemDTO dto;
        dto.id = extractIdFromPath(req.requestURI.to!string);
        dto.materialId = jsonStr(j, "materialId");
        dto.plantId = jsonStr(j, "plantId");
        dto.storageLocationId = jsonStr(j, "storageLocationId");
        dto.unrestrictedUseQty = jsonStr(j, "unrestrictedUseQty");
        dto.qualityInspectionQty = jsonStr(j, "qualityInspectionQty");
        dto.blockedQty = jsonStr(j, "blockedQty");
        dto.openInboundQty = jsonStr(j, "openInboundQty");
        dto.lastMovementAt = jsonStr(j, "lastMovementAt");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, inventory.updateStockItem(dto), 200, "Stock item updated", 404);
    }

    private void handleDeleteStockItem(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeDeleteResult(res, inventory.removeStockItem(extractIdFromPath(req.requestURI.to!string)), "Stock item deleted");
    }

    private void handleListGoodsReceipts(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeListResponse!GoodsReceipt(res, inventory.listReceipts(), &goodsReceiptToJson);
    }

    private void handleGetGoodsReceipt(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = inventory.getReceipt(extractIdFromPath(req.requestURI.to!string));
        if (item is null) { writeError(res, 404, "Goods receipt not found"); return; }
        res.writeJsonBody(goodsReceiptToJson(*item), 200);
    }

    private void handleCreateGoodsReceipt(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        GoodsReceiptDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.purchaseOrderId = jsonStr(j, "purchaseOrderId");
        dto.plantId = jsonStr(j, "plantId");
        dto.storageLocationId = jsonStr(j, "storageLocationId");
        dto.materialId = jsonStr(j, "materialId");
        dto.movementType = jsonStr(j, "movementType");
        dto.quantity = jsonStr(j, "quantity");
        dto.postedBy = jsonStr(j, "postedBy");
        dto.postingDate = jsonStr(j, "postingDate");
        dto.documentDate = jsonStr(j, "documentDate");
        dto.createdAt = jsonStr(j, "createdAt");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, inventory.createGoodsReceipt(dto), 201, "Goods receipt posted", 400);
    }

    private void handleDeleteGoodsReceipt(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeDeleteResult(res, inventory.removeGoodsReceipt(extractIdFromPath(req.requestURI.to!string)), "Goods receipt deleted");
    }

    private string tenantIdOf(scope HTTPServerRequest req) {
        return req.headers.get("X-Tenant-Id", "");
    }

    private void writeCommandResult(scope HTTPServerResponse res, CommandResult result, int successStatus, string successMessage, int failureStatus) {
        if (result.success) {
            res.writeJsonBody(successPayload(result.id, successMessage), successStatus);
        } else {
            writeError(res, failureStatus, result.error);
        }
    }

    private void writeDeleteResult(scope HTTPServerResponse res, CommandResult result, string message) {
        if (result.success) {
            res.writeJsonBody(successPayload(result.id, message), 200);
        } else {
            writeError(res, 404, result.error);
        }
    }

    private void writeListResponse(T)(scope HTTPServerResponse res, T[] items, Json function(T) mapper) {
        auto resources = Json.emptyArray;
        foreach (item; items) resources ~= mapper(item);
        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = resources;
        res.writeJsonBody(payload, 200);
    }
}