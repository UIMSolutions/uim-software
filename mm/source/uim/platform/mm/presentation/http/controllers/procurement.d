module uim.platform.mm.presentation.http.controllers.procurement;

import std.conv : to;
import uim.platform.mm;

@safe:

class ProcurementController : SAPController {
    private ManageProcurementUseCase procurement;

    this(ManageProcurementUseCase procurement) {
        this.procurement = procurement;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);

        router.get("/api/v1/mm/purchase-requisitions", &handleListRequisitions);
        router.get("/api/v1/mm/purchase-requisitions/*", &handleGetRequisition);
        router.post("/api/v1/mm/purchase-requisitions", &handleCreateRequisition);
        router.put("/api/v1/mm/purchase-requisitions/*", &handleUpdateRequisition);
        router.delete_("/api/v1/mm/purchase-requisitions/*", &handleDeleteRequisition);
        router.post("/api/v1/mm/purchase-requisition-conversions/*", &handleConvertRequisition);

        router.get("/api/v1/mm/purchase-orders", &handleListOrders);
        router.get("/api/v1/mm/purchase-orders/*", &handleGetOrder);
        router.post("/api/v1/mm/purchase-orders", &handleCreateOrder);
        router.put("/api/v1/mm/purchase-orders/*", &handleUpdateOrder);
        router.delete_("/api/v1/mm/purchase-orders/*", &handleDeleteOrder);
    }

    private void handleListRequisitions(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeListResponse!PurchaseRequisition(res, procurement.listRequisitions(), &purchaseRequisitionToJson);
    }

    private void handleGetRequisition(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = procurement.getRequisition(extractIdFromPath(req.requestURI.to!string));
        if (item is null) { writeError(res, 404, "Purchase requisition not found"); return; }
        res.writeJsonBody(purchaseRequisitionToJson(*item), 200);
    }

    private void handleCreateRequisition(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PurchaseRequisitionDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.materialId = jsonStr(j, "materialId");
        dto.plantId = jsonStr(j, "plantId");
        dto.storageLocationId = jsonStr(j, "storageLocationId");
        dto.quantity = jsonStr(j, "quantity");
        dto.unit = jsonStr(j, "unit");
        dto.requiredDate = jsonStr(j, "requiredDate");
        dto.accountAssignment = jsonStr(j, "accountAssignment");
        dto.status = jsonStr(j, "status");
        dto.requestedBy = jsonStr(j, "requestedBy");
        dto.sourceVendorId = jsonStr(j, "sourceVendorId");
        dto.createdAt = jsonStr(j, "createdAt");
        writeCommandResult(res, procurement.createRequisition(dto), 201, "Purchase requisition created", 400);
    }

    private void handleUpdateRequisition(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PurchaseRequisitionDTO dto;
        dto.id = extractIdFromPath(req.requestURI.to!string);
        dto.materialId = jsonStr(j, "materialId");
        dto.plantId = jsonStr(j, "plantId");
        dto.storageLocationId = jsonStr(j, "storageLocationId");
        dto.quantity = jsonStr(j, "quantity");
        dto.unit = jsonStr(j, "unit");
        dto.requiredDate = jsonStr(j, "requiredDate");
        dto.accountAssignment = jsonStr(j, "accountAssignment");
        dto.status = jsonStr(j, "status");
        dto.requestedBy = jsonStr(j, "requestedBy");
        dto.sourceVendorId = jsonStr(j, "sourceVendorId");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, procurement.updateRequisition(dto), 200, "Purchase requisition updated", 404);
    }

    private void handleDeleteRequisition(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeDeleteResult(res, procurement.removeRequisition(extractIdFromPath(req.requestURI.to!string)), "Purchase requisition deleted");
    }

    private void handleConvertRequisition(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PurchaseOrderDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.vendorId = jsonStr(j, "vendorId");
        dto.purchasingOrg = jsonStr(j, "purchasingOrg");
        dto.currency = jsonStr(j, "currency");
        dto.orderedBy = jsonStr(j, "orderedBy");
        dto.netPrice = jsonStr(j, "netPrice");
        dto.deliveryDate = jsonStr(j, "deliveryDate");
        dto.createdAt = jsonStr(j, "createdAt");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(
            res,
            procurement.convertRequisitionToOrder(extractIdFromPath(req.requestURI.to!string), dto),
            201,
            "Purchase order created from requisition",
            400
        );
    }

    private void handleListOrders(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeListResponse!PurchaseOrder(res, procurement.listOrders(), &purchaseOrderToJson);
    }

    private void handleGetOrder(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = procurement.getOrder(extractIdFromPath(req.requestURI.to!string));
        if (item is null) { writeError(res, 404, "Purchase order not found"); return; }
        res.writeJsonBody(purchaseOrderToJson(*item), 200);
    }

    private void handleCreateOrder(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PurchaseOrderDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.vendorId = jsonStr(j, "vendorId");
        dto.plantId = jsonStr(j, "plantId");
        dto.purchasingOrg = jsonStr(j, "purchasingOrg");
        dto.currency = jsonStr(j, "currency");
        dto.status = jsonStr(j, "status");
        dto.referenceRequisitionId = jsonStr(j, "referenceRequisitionId");
        dto.orderedBy = jsonStr(j, "orderedBy");
        dto.lineMaterialId = jsonStr(j, "lineMaterialId");
        dto.lineQuantity = jsonStr(j, "lineQuantity");
        dto.receivedQuantity = jsonStr(j, "receivedQuantity");
        dto.unit = jsonStr(j, "unit");
        dto.netPrice = jsonStr(j, "netPrice");
        dto.deliveryDate = jsonStr(j, "deliveryDate");
        dto.createdAt = jsonStr(j, "createdAt");
        writeCommandResult(res, procurement.createOrder(dto), 201, "Purchase order created", 400);
    }

    private void handleUpdateOrder(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PurchaseOrderDTO dto;
        dto.id = extractIdFromPath(req.requestURI.to!string);
        dto.vendorId = jsonStr(j, "vendorId");
        dto.plantId = jsonStr(j, "plantId");
        dto.purchasingOrg = jsonStr(j, "purchasingOrg");
        dto.currency = jsonStr(j, "currency");
        dto.status = jsonStr(j, "status");
        dto.referenceRequisitionId = jsonStr(j, "referenceRequisitionId");
        dto.orderedBy = jsonStr(j, "orderedBy");
        dto.lineMaterialId = jsonStr(j, "lineMaterialId");
        dto.lineQuantity = jsonStr(j, "lineQuantity");
        dto.receivedQuantity = jsonStr(j, "receivedQuantity");
        dto.unit = jsonStr(j, "unit");
        dto.netPrice = jsonStr(j, "netPrice");
        dto.deliveryDate = jsonStr(j, "deliveryDate");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, procurement.updateOrder(dto), 200, "Purchase order updated", 404);
    }

    private void handleDeleteOrder(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeDeleteResult(res, procurement.removeOrder(extractIdFromPath(req.requestURI.to!string)), "Purchase order deleted");
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