module uim.platform.mm.presentation.http.json_utils;

import std.conv : to;
import uim.platform.mm;

@safe:

Json materialToJson(Material value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["materialNumber"] = Json(value.materialNumber);
    j["description"] = Json(value.description);
    j["baseUnit"] = Json(value.baseUnit);
    j["materialType"] = Json(value.materialType.to!string);
    j["materialGroup"] = Json(value.materialGroup);
    j["valuationClass"] = Json(value.valuationClass);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json plantToJson(Plant value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["plantCode"] = Json(value.plantCode);
    j["name"] = Json(value.name);
    j["companyCode"] = Json(value.companyCode);
    j["country"] = Json(value.country);
    j["purchasingOrg"] = Json(value.purchasingOrg);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json storageLocationToJson(StorageLocation value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["plantId"] = Json(value.plantId);
    j["storageLocationCode"] = Json(value.storageLocationCode);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json vendorToJson(SupplierVendor value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["vendorNumber"] = Json(value.vendorNumber);
    j["name"] = Json(value.name);
    j["purchasingOrg"] = Json(value.purchasingOrg);
    j["currency"] = Json(value.currency);
    j["paymentTerms"] = Json(value.paymentTerms);
    j["incoterms"] = Json(value.incoterms);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json purchasingInfoRecordToJson(PurchasingInfoRecord value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["materialId"] = Json(value.materialId);
    j["vendorId"] = Json(value.vendorId);
    j["plantId"] = Json(value.plantId);
    j["purchasingOrg"] = Json(value.purchasingOrg);
    j["orderUnit"] = Json(value.orderUnit);
    j["netPrice"] = Json(value.netPrice);
    j["currency"] = Json(value.currency);
    j["leadTimeDays"] = Json(value.leadTimeDays);
    j["minimumOrderQuantity"] = Json(value.minimumOrderQuantity);
    j["sourceListNote"] = Json(value.sourceListNote);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json purchaseRequisitionToJson(PurchaseRequisition value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["materialId"] = Json(value.materialId);
    j["plantId"] = Json(value.plantId);
    j["storageLocationId"] = Json(value.storageLocationId);
    j["quantity"] = Json(value.quantity);
    j["unit"] = Json(value.unit);
    j["requiredDate"] = Json(value.requiredDate);
    j["accountAssignment"] = Json(value.accountAssignment);
    j["status"] = Json(value.status.to!string);
    j["requestedBy"] = Json(value.requestedBy);
    j["sourceVendorId"] = Json(value.sourceVendorId);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json purchaseOrderToJson(PurchaseOrder value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["vendorId"] = Json(value.vendorId);
    j["plantId"] = Json(value.plantId);
    j["purchasingOrg"] = Json(value.purchasingOrg);
    j["currency"] = Json(value.currency);
    j["status"] = Json(value.status.to!string);
    j["referenceRequisitionId"] = Json(value.referenceRequisitionId);
    j["orderedBy"] = Json(value.orderedBy);
    j["lineMaterialId"] = Json(value.lineMaterialId);
    j["lineQuantity"] = Json(value.lineQuantity);
    j["receivedQuantity"] = Json(value.receivedQuantity);
    j["unit"] = Json(value.unit);
    j["netPrice"] = Json(value.netPrice);
    j["deliveryDate"] = Json(value.deliveryDate);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json goodsReceiptToJson(GoodsReceipt value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["purchaseOrderId"] = Json(value.purchaseOrderId);
    j["plantId"] = Json(value.plantId);
    j["storageLocationId"] = Json(value.storageLocationId);
    j["materialId"] = Json(value.materialId);
    j["movementType"] = Json(value.movementType.to!string);
    j["quantity"] = Json(value.quantity);
    j["postedBy"] = Json(value.postedBy);
    j["postingDate"] = Json(value.postingDate);
    j["documentDate"] = Json(value.documentDate);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json stockItemToJson(StockItem value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["materialId"] = Json(value.materialId);
    j["plantId"] = Json(value.plantId);
    j["storageLocationId"] = Json(value.storageLocationId);
    j["unrestrictedUseQty"] = Json(value.unrestrictedUseQty);
    j["qualityInspectionQty"] = Json(value.qualityInspectionQty);
    j["blockedQty"] = Json(value.blockedQty);
    j["openInboundQty"] = Json(value.openInboundQty);
    j["lastMovementAt"] = Json(value.lastMovementAt);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json successPayload(string id, string message) {
    auto payload = Json.emptyObject;
    payload["id"] = Json(id);
    payload["message"] = Json(message);
    return payload;
}