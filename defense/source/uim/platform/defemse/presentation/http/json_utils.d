module uim.platform.defense.presentation.http.json_utils;

import std.conv : to;
import uim.platform.defense;

@safe:

Json missionPlanToJson(ref MissionPlan value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["reference"] = Json(value.reference);
    j["name"] = Json(value.name);
    j["objective"] = Json(value.objective);
    j["missionType"] = Json(value.missionType);
    j["region"] = Json(value.region);
    j["status"] = Json(value.status.to!string);
    j["assignedContingentIds"] = Json(value.assignedContingentIds);
    j["locationId"] = Json(value.locationId);
    j["downstreamProcessState"] = Json(value.downstreamProcessState);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json exerciseToJson(ref Exercise value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["reference"] = Json(value.reference);
    j["name"] = Json(value.name);
    j["exerciseType"] = Json(value.exerciseType);
    j["exerciseScope"] = Json(value.exerciseScope);
    j["status"] = Json(value.status.to!string);
    j["missionPlanId"] = Json(value.missionPlanId);
    j["plannedStart"] = Json(value.plannedStart);
    j["plannedEnd"] = Json(value.plannedEnd);
    j["contingencyLevel"] = Json(value.contingencyLevel);
    j["relocationRequired"] = Json(value.relocationRequired);
    j["locationId"] = Json(value.locationId);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json contingentToJson(ref Contingent value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["code"] = Json(value.code);
    j["name"] = Json(value.name);
    j["unitType"] = Json(value.unitType);
    j["personnelStrength"] = Json(value.personnelStrength);
    j["equipmentCount"] = Json(value.equipmentCount);
    j["status"] = Json(value.status.to!string);
    j["readinessStatus"] = Json(value.readinessStatus.to!string);
    j["currentLocationId"] = Json(value.currentLocationId);
    j["destinationLocationId"] = Json(value.destinationLocationId);
    j["transportMode"] = Json(value.transportMode);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json readinessProfileToJson(ref ReadinessProfile value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["contingentId"] = Json(value.contingentId);
    j["missionPlanId"] = Json(value.missionPlanId);
    j["personnelReadyPercent"] = Json(value.personnelReadyPercent);
    j["equipmentReadyPercent"] = Json(value.equipmentReadyPercent);
    j["supplyReadyPercent"] = Json(value.supplyReadyPercent);
    j["maintenanceOpenCount"] = Json(value.maintenanceOpenCount);
    j["mobilityState"] = Json(value.mobilityState);
    j["communicationState"] = Json(value.communicationState);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json redeploymentOrderToJson(ref RedeploymentOrder value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["missionPlanId"] = Json(value.missionPlanId);
    j["contingentId"] = Json(value.contingentId);
    j["originLocationId"] = Json(value.originLocationId);
    j["destinationLocationId"] = Json(value.destinationLocationId);
    j["transportType"] = Json(value.transportType);
    j["priority"] = Json(value.priority);
    j["executionWindow"] = Json(value.executionWindow);
    j["status"] = Json(value.status.to!string);
    j["reason"] = Json(value.reason);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json maintenanceTaskToJson(ref MaintenanceTask value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["contingentId"] = Json(value.contingentId);
    j["equipmentId"] = Json(value.equipmentId);
    j["taskType"] = Json(value.taskType);
    j["priority"] = Json(value.priority);
    j["dueAt"] = Json(value.dueAt);
    j["status"] = Json(value.status.to!string);
    j["locationId"] = Json(value.locationId);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json budgetTriggerToJson(ref BudgetTrigger value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["missionPlanId"] = Json(value.missionPlanId);
    j["sourceProcess"] = Json(value.sourceProcess);
    j["amount"] = Json(value.amount);
    j["currency"] = Json(value.currency);
    j["triggerReason"] = Json(value.triggerReason);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json offlineSyncRecordToJson(ref OfflineSyncRecord value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["recordType"] = Json(value.recordType);
    j["recordId"] = Json(value.recordId);
    j["action"] = Json(value.action);
    j["payload"] = Json(value.payload);
    j["status"] = Json(value.status.to!string);
    j["lastSyncedAt"] = Json(value.lastSyncedAt);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}