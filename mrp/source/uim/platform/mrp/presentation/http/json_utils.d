module uim.platform.mrp.presentation.http.json_utils;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

Json materialToJson(Material e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["plantId"] = Json(e.plantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["materialNumber"] = Json(e.materialNumber);
    j["baseUnit"] = Json(e.baseUnit);
    j["mrpProcedure"] = Json(e.mrpProcedure.to!string);
    j["lotSizingProcedure"] = Json(e.lotSizingProcedure.to!string);
    j["procurementType"] = Json(e.procurementType.to!string);
    j["status"] = Json(e.status.to!string);
    j["safetyStock"] = Json(e.safetyStock);
    j["reorderPoint"] = Json(e.reorderPoint);
    j["lotSize"] = Json(e.lotSize);
    j["minimumLotSize"] = Json(e.minimumLotSize);
    j["independentDemand"] = Json(e.independentDemand);
    j["planningTimeFenceDays"] = Json(e.planningTimeFenceDays);
    j["inHouseProductionTimeDays"] = Json(e.inHouseProductionTimeDays);
    j["plannedDeliveryTimeDays"] = Json(e.plannedDeliveryTimeDays);
    j["grProcessingTimeDays"] = Json(e.grProcessingTimeDays);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json plantToJson(Plant e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["plantCode"] = Json(e.plantCode);
    j["planningScope"] = Json(e.planningScope.to!string);
    j["mrpAreas"] = Json(e.mrpAreas);
    j["companyCode"] = Json(e.companyCode);
    j["country"] = Json(e.country);
    j["timezone"] = Json(e.timezone);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json billOfMaterialToJson(BillOfMaterial e) {
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["plantId"] = Json(e.plantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["parentMaterialId"] = Json(e.parentMaterialId);
    j["componentMaterialId"] = Json(e.componentMaterialId);
    j["componentQuantity"] = Json(e.componentQuantity);
    j["baseQuantity"] = Json(e.baseQuantity);
    j["scrapPercent"] = Json(e.scrapPercent);
    j["validFrom"] = Json(e.validFrom);
    j["validTo"] = Json(e.validTo);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json inventoryPositionToJson(InventoryPosition e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["plantId"] = Json(e.plantId);
    j["materialId"] = Json(e.materialId);
    j["stockSegment"] = Json(e.stockSegment.to!string);
    j["storageLocation"] = Json(e.storageLocation);
    j["onHandQuantity"] = Json(e.onHandQuantity);
    j["scheduledReceipts"] = Json(e.scheduledReceipts);
    j["reservedQuantity"] = Json(e.reservedQuantity);
    j["openPurchaseOrders"] = Json(e.openPurchaseOrders);
    j["openProductionOrders"] = Json(e.openProductionOrders);
    j["snapshotDate"] = Json(e.snapshotDate);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json mrpRunToJson(MrpRun e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["plantId"] = Json(e.plantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["mode"] = Json(e.mode.to!string);
    j["status"] = Json(e.status.to!string);
    j["planningDate"] = Json(e.planningDate);
    j["horizonDays"] = Json(e.horizonDays);
    j["includeExternalRequirements"] = Json(e.includeExternalRequirements);
    j["includeDependentRequirements"] = Json(e.includeDependentRequirements);
    j["includeSafetyStock"] = Json(e.includeSafetyStock);
    j["generatedProposalCount"] = Json(e.generatedProposalCount);
    j["executedBy"] = Json(e.executedBy);
    j["executedAt"] = Json(e.executedAt);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json procurementProposalToJson(ProcurementProposal e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["mrpRunId"] = Json(e.mrpRunId);
    j["plantId"] = Json(e.plantId);
    j["materialId"] = Json(e.materialId);
    j["proposalType"] = Json(e.proposalType.to!string);
    j["status"] = Json(e.status.to!string);
    j["quantity"] = Json(e.quantity);
    j["dueDate"] = Json(e.dueDate);
    j["source"] = Json(e.source);
    j["exceptionMessage"] = Json(e.exceptionMessage);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}
