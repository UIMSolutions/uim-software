module uim.platform.dm.presentation.http.json_utils;

import std.conv : to;

import uim.platform.dm;
import uim.platform.dm.domain.entities.manufacturing_entities;

@safe:

Json productionOrderToJson(ref ProductionOrder value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["orderNumber"] = Json(value.orderNumber);
    j["materialId"] = Json(value.materialId);
    j["plant"] = Json(value.plant);
    j["quantity"] = Json(value.quantity);
    j["unit"] = Json(value.unit);
    j["scheduledStart"] = Json(value.scheduledStart);
    j["scheduledEnd"] = Json(value.scheduledEnd);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json operationActivityToJson(ref OperationActivity value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["productionOrderId"] = Json(value.productionOrderId);
    j["operationCode"] = Json(value.operationCode);
    j["workCenterId"] = Json(value.workCenterId);
    j["sequence"] = Json(value.sequence);
    j["plannedDuration"] = Json(value.plannedDuration);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json workCenterToJson(ref WorkCenter value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["centerCode"] = Json(value.centerCode);
    j["description"] = Json(value.description);
    j["plant"] = Json(value.plant);
    j["capacity"] = Json(value.capacity);
    j["capacityUnit"] = Json(value.capacityUnit);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json resourceToJson(ref Resource value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["resourceCode"] = Json(value.resourceCode);
    j["workCenterId"] = Json(value.workCenterId);
    j["resourceType"] = Json(value.resourceType.to!string);
    j["availability"] = Json(value.availability);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json materialToJson(ref Material value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["materialNumber"] = Json(value.materialNumber);
    j["description"] = Json(value.description);
    j["baseUnit"] = Json(value.baseUnit);
    j["revision"] = Json(value.revision);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json shopFloorControlToJson(ref ShopFloorControl value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["productionOrderId"] = Json(value.productionOrderId);
    j["dispatchRule"] = Json(value.dispatchRule);
    j["priority"] = Json(value.priority);
    j["mode"] = Json(value.mode.to!string);
    j["releaseStrategy"] = Json(value.releaseStrategy);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json workInstructionToJson(ref WorkInstruction value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["operationActivityId"] = Json(value.operationActivityId);
    j["title"] = Json(value.title);
    j["documentRef"] = Json(value.documentRef);
    j["version"] = Json(value.instructionVersion);
    j["language"] = Json(value.language);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json qualityInspectionToJson(ref QualityInspection value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["productionOrderId"] = Json(value.productionOrderId);
    j["characteristic"] = Json(value.characteristic);
    j["sampleSize"] = Json(value.sampleSize);
    j["resultValue"] = Json(value.resultValue);
    j["status"] = Json(value.status.to!string);
    j["inspector"] = Json(value.inspector);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json nonconformanceToJson(ref Nonconformance value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["productionOrderId"] = Json(value.productionOrderId);
    j["defectCode"] = Json(value.defectCode);
    j["defectText"] = Json(value.defectText);
    j["severity"] = Json(value.severity.to!string);
    j["disposition"] = Json(value.disposition);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json genealogyRecordToJson(ref GenealogyRecord value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["productionOrderId"] = Json(value.productionOrderId);
    j["parentSerial"] = Json(value.parentSerial);
    j["childSerial"] = Json(value.childSerial);
    j["componentMaterialId"] = Json(value.componentMaterialId);
    j["assembledAt"] = Json(value.assembledAt);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}
