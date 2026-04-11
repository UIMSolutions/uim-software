/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.presentation.http.json_utils;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

Json shipmentToJson(Shipment e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["shipmentNumber"] = Json(e.shipmentNumber);
    j["carrierName"] = Json(e.carrierName);
    j["carrierTrackingId"] = Json(e.carrierTrackingId);
    j["transportMode"] = Json(e.transportMode.to!string);
    j["status"] = Json(e.status.to!string);
    j["originLocationId"] = Json(e.originLocationId);
    j["destinationLocationId"] = Json(e.destinationLocationId);
    j["plannedDeparture"] = Json(e.plannedDeparture);
    j["plannedArrival"] = Json(e.plannedArrival);
    j["actualDeparture"] = Json(e.actualDeparture);
    j["actualArrival"] = Json(e.actualArrival);
    j["waypoints"] = Json(e.waypoints);
    j["trackingModelId"] = Json(e.trackingModelId);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json deliveryToJson(Delivery e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["deliveryNumber"] = Json(e.deliveryNumber);
    j["deliveryType"] = Json(e.deliveryType.to!string);
    j["status"] = Json(e.status.to!string);
    j["shipmentId"] = Json(e.shipmentId);
    j["purchaseOrderId"] = Json(e.purchaseOrderId);
    j["salesOrderId"] = Json(e.salesOrderId);
    j["originLocationId"] = Json(e.originLocationId);
    j["destinationLocationId"] = Json(e.destinationLocationId);
    j["carrierReference"] = Json(e.carrierReference);
    j["items"] = Json(e.items);
    j["plannedDate"] = Json(e.plannedDate);
    j["actualDate"] = Json(e.actualDate);
    j["proofOfDelivery"] = Json(e.proofOfDelivery);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json purchaseOrderToJson(PurchaseOrder e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["orderNumber"] = Json(e.orderNumber);
    j["status"] = Json(e.status.to!string);
    j["supplierId"] = Json(e.supplierId);
    j["buyerLocationId"] = Json(e.buyerLocationId);
    j["supplierLocationId"] = Json(e.supplierLocationId);
    j["items"] = Json(e.items);
    j["orderDate"] = Json(e.orderDate);
    j["expectedDeliveryDate"] = Json(e.expectedDeliveryDate);
    j["actualDeliveryDate"] = Json(e.actualDeliveryDate);
    j["currency"] = Json(e.currency);
    j["totalAmount"] = Json(e.totalAmount);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json salesOrderToJson(SalesOrder e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["orderNumber"] = Json(e.orderNumber);
    j["status"] = Json(e.status.to!string);
    j["customerId"] = Json(e.customerId);
    j["sellerLocationId"] = Json(e.sellerLocationId);
    j["customerLocationId"] = Json(e.customerLocationId);
    j["items"] = Json(e.items);
    j["orderDate"] = Json(e.orderDate);
    j["requestedDeliveryDate"] = Json(e.requestedDeliveryDate);
    j["actualDeliveryDate"] = Json(e.actualDeliveryDate);
    j["currency"] = Json(e.currency);
    j["totalAmount"] = Json(e.totalAmount);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json trackingEventToJson(TrackingEvent e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["eventType"] = Json(e.eventType.to!string);
    j["status"] = Json(e.status.to!string);
    j["trackedObjectId"] = Json(e.trackedObjectId);
    j["trackedObjectType"] = Json(e.trackedObjectType);
    j["locationId"] = Json(e.locationId);
    j["latitude"] = Json(e.latitude);
    j["longitude"] = Json(e.longitude);
    j["eventTimestamp"] = Json(e.eventTimestamp);
    j["reportedBy"] = Json(e.reportedBy);
    j["sensorData"] = Json(e.sensorData);
    j["milestone"] = Json(e.milestone);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json trackedProcessToJson(TrackedProcess e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["processType"] = Json(e.processType.to!string);
    j["status"] = Json(e.status.to!string);
    j["trackingModelId"] = Json(e.trackingModelId);
    j["shipmentIds"] = Json(e.shipmentIds);
    j["deliveryIds"] = Json(e.deliveryIds);
    j["purchaseOrderIds"] = Json(e.purchaseOrderIds);
    j["salesOrderIds"] = Json(e.salesOrderIds);
    j["currentMilestone"] = Json(e.currentMilestone);
    j["completionPercent"] = Json(e.completionPercent);
    j["startDate"] = Json(e.startDate);
    j["endDate"] = Json(e.endDate);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json locationToJson(Location e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["locationType"] = Json(e.locationType.to!string);
    j["address"] = Json(e.address);
    j["city"] = Json(e.city);
    j["country"] = Json(e.country);
    j["postalCode"] = Json(e.postalCode);
    j["latitude"] = Json(e.latitude);
    j["longitude"] = Json(e.longitude);
    j["timezone"] = Json(e.timezone);
    j["sourceSystem"] = Json(e.sourceSystem);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json trackingModelToJson(TrackingModel e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["status"] = Json(e.status.to!string);
    j["trackedObjectType"] = Json(e.trackedObjectType);
    j["expectedEvents"] = Json(e.expectedEvents);
    j["milestones"] = Json(e.milestones);
    j["correlationRules"] = Json(e.correlationRules);
    j["exceptionRules"] = Json(e.exceptionRules);
    j["version"] = Json(e.version_);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}
