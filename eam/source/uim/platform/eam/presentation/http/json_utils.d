/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.presentation.http.json_utils;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

Json equipmentToJson(ref Equipment e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["equipmentNumber"] = Json(e.equipmentNumber);
    j["category"] = Json(e.category.to!string);
    j["status"] = Json(e.status.to!string);
    j["functionalLocationId"] = Json(e.functionalLocationId);
    j["manufacturer"] = Json(e.manufacturer);
    j["modelNumber"] = Json(e.modelNumber);
    j["serialNumber"] = Json(e.serialNumber);
    j["installationDate"] = Json(e.installationDate);
    j["warrantyEndDate"] = Json(e.warrantyEndDate);
    j["acquisitionValue"] = Json(e.acquisitionValue);
    j["currency"] = Json(e.currency);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json functionalLocationToJson(ref FunctionalLocation fl) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(fl.id);
    j["tenantId"] = Json(fl.tenantId);
    j["name"] = Json(fl.name);
    j["description"] = Json(fl.description);
    j["locationLabel"] = Json(fl.locationLabel);
    j["locationType"] = Json(fl.locationType.to!string);
    j["status"] = Json(fl.status.to!string);
    j["parentLocationId"] = Json(fl.parentLocationId);
    j["plantSection"] = Json(fl.plantSection);
    j["costCenter"] = Json(fl.costCenter);
    j["address"] = Json(fl.address);
    j["createdBy"] = Json(fl.createdBy);
    j["modifiedBy"] = Json(fl.modifiedBy);
    j["createdAt"] = Json(fl.createdAt);
    j["modifiedAt"] = Json(fl.modifiedAt);
    return j;
}

Json maintenanceOrderToJson(ref MaintenanceOrder o) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(o.id);
    j["tenantId"] = Json(o.tenantId);
    j["name"] = Json(o.name);
    j["description"] = Json(o.description);
    j["orderNumber"] = Json(o.orderNumber);
    j["orderType"] = Json(o.orderType.to!string);
    j["status"] = Json(o.status.to!string);
    j["priority"] = Json(o.priority.to!string);
    j["equipmentId"] = Json(o.equipmentId);
    j["functionalLocationId"] = Json(o.functionalLocationId);
    j["workCenterId"] = Json(o.workCenterId);
    j["notificationId"] = Json(o.notificationId);
    j["plannedStartDate"] = Json(o.plannedStartDate);
    j["plannedEndDate"] = Json(o.plannedEndDate);
    j["actualStartDate"] = Json(o.actualStartDate);
    j["actualEndDate"] = Json(o.actualEndDate);
    j["estimatedCost"] = Json(o.estimatedCost);
    j["actualCost"] = Json(o.actualCost);
    j["assignedTo"] = Json(o.assignedTo);
    j["createdBy"] = Json(o.createdBy);
    j["modifiedBy"] = Json(o.modifiedBy);
    j["createdAt"] = Json(o.createdAt);
    j["modifiedAt"] = Json(o.modifiedAt);
    return j;
}

Json maintenanceNotificationToJson(ref MaintenanceNotification n) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(n.id);
    j["tenantId"] = Json(n.tenantId);
    j["name"] = Json(n.name);
    j["description"] = Json(n.description);
    j["notificationNumber"] = Json(n.notificationNumber);
    j["notificationType"] = Json(n.notificationType.to!string);
    j["status"] = Json(n.status.to!string);
    j["priority"] = Json(n.priority.to!string);
    j["equipmentId"] = Json(n.equipmentId);
    j["functionalLocationId"] = Json(n.functionalLocationId);
    j["breakdownIndicator"] = Json(n.breakdownIndicator);
    j["reportedBy"] = Json(n.reportedBy);
    j["reportedDate"] = Json(n.reportedDate);
    j["requiredStartDate"] = Json(n.requiredStartDate);
    j["requiredEndDate"] = Json(n.requiredEndDate);
    j["createdBy"] = Json(n.createdBy);
    j["modifiedBy"] = Json(n.modifiedBy);
    j["createdAt"] = Json(n.createdAt);
    j["modifiedAt"] = Json(n.modifiedAt);
    return j;
}

Json maintenancePlanToJson(ref MaintenancePlan p) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(p.id);
    j["tenantId"] = Json(p.tenantId);
    j["name"] = Json(p.name);
    j["description"] = Json(p.description);
    j["category"] = Json(p.category.to!string);
    j["status"] = Json(p.status.to!string);
    j["cycleLength"] = Json(p.cycleLength);
    j["cycleUnit"] = Json(p.cycleUnit);
    j["leadTimeOffset"] = Json(p.leadTimeOffset);
    j["schedulingPeriod"] = Json(p.schedulingPeriod);
    j["lastScheduledDate"] = Json(p.lastScheduledDate);
    j["nextDueDate"] = Json(p.nextDueDate);
    j["createdBy"] = Json(p.createdBy);
    j["modifiedBy"] = Json(p.modifiedBy);
    j["createdAt"] = Json(p.createdAt);
    j["modifiedAt"] = Json(p.modifiedAt);
    return j;
}

Json workCenterToJson(ref WorkCenter wc) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(wc.id);
    j["tenantId"] = Json(wc.tenantId);
    j["name"] = Json(wc.name);
    j["description"] = Json(wc.description);
    j["category"] = Json(wc.category.to!string);
    j["plantSection"] = Json(wc.plantSection);
    j["costCenter"] = Json(wc.costCenter);
    j["capacity"] = Json(wc.capacity);
    j["capacityUnit"] = Json(wc.capacityUnit);
    j["responsiblePerson"] = Json(wc.responsiblePerson);
    j["createdBy"] = Json(wc.createdBy);
    j["modifiedBy"] = Json(wc.modifiedBy);
    j["createdAt"] = Json(wc.createdAt);
    j["modifiedAt"] = Json(wc.modifiedAt);
    return j;
}

Json materialBOMToJson(ref MaterialBOM bom) {
    auto j = Json.emptyObject;
    j["id"] = Json(bom.id);
    j["tenantId"] = Json(bom.tenantId);
    j["name"] = Json(bom.name);
    j["description"] = Json(bom.description);
    j["equipmentId"] = Json(bom.equipmentId);
    j["materialNumber"] = Json(bom.materialNumber);
    j["materialDescription"] = Json(bom.materialDescription);
    j["quantity"] = Json(bom.quantity);
    j["unit"] = Json(bom.unit);
    j["storageLocation"] = Json(bom.storageLocation);
    j["supplier"] = Json(bom.supplier);
    j["unitPrice"] = Json(bom.unitPrice);
    j["currency"] = Json(bom.currency);
    j["createdBy"] = Json(bom.createdBy);
    j["modifiedBy"] = Json(bom.modifiedBy);
    j["createdAt"] = Json(bom.createdAt);
    j["modifiedAt"] = Json(bom.modifiedAt);
    return j;
}

Json maintenanceItemToJson(ref MaintenanceItem mi) {
    auto j = Json.emptyObject;
    j["id"] = Json(mi.id);
    j["tenantId"] = Json(mi.tenantId);
    j["name"] = Json(mi.name);
    j["description"] = Json(mi.description);
    j["maintenancePlanId"] = Json(mi.maintenancePlanId);
    j["equipmentId"] = Json(mi.equipmentId);
    j["functionalLocationId"] = Json(mi.functionalLocationId);
    j["taskListId"] = Json(mi.taskListId);
    j["taskListDescription"] = Json(mi.taskListDescription);
    j["workCenterId"] = Json(mi.workCenterId);
    j["orderType"] = Json(mi.orderType);
    j["cycle"] = Json(mi.cycle);
    j["cycleUnit"] = Json(mi.cycleUnit);
    j["createdBy"] = Json(mi.createdBy);
    j["modifiedBy"] = Json(mi.modifiedBy);
    j["createdAt"] = Json(mi.createdAt);
    j["modifiedAt"] = Json(mi.modifiedAt);
    return j;
}
