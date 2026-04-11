/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.types;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

// --- ID Aliases ---
alias ShipmentId = string;
alias DeliveryId = string;
alias PurchaseOrderId = string;
alias SalesOrderId = string;
alias TrackingEventId = string;
alias TrackedProcessId = string;
alias LocationId = string;
alias TrackingModelId = string;
alias TenantId = string;
alias UserId = string;

// --- Enumerations ---

enum TransportMode {
    road,
    rail,
    ocean,
    air,
    multimodal
}

enum ShipmentStatus {
    created,
    inTransit,
    delivered,
    completed,
    cancelled,
    delayed,
    exception
}

enum DeliveryType {
    inbound,
    outbound
}

enum DeliveryStatus {
    created,
    dispatched,
    inTransit,
    received,
    confirmed,
    cancelled,
    exception
}

enum PurchaseOrderStatus {
    created,
    confirmed,
    shipped,
    received,
    invoiced,
    cancelled,
    exception
}

enum SalesOrderStatus {
    accepted,
    picking,
    packing,
    shipped,
    delivered,
    cancelled,
    exception
}

enum EventType {
    locationUpdate,
    statusChange,
    milestoneCompletion,
    exception,
    sensorReading,
    departure,
    arrival,
    goodsIssue,
    goodsReceipt,
    proofOfDelivery
}

enum EventStatus {
    created,
    processed,
    correlated,
    error
}

enum ProcessType {
    shipmentTracking,
    deliveryMonitoring,
    poFulfillment,
    soFulfillment,
    endToEnd
}

enum ProcessStatus {
    initiated,
    inProgress,
    completed,
    exception,
    cancelled
}

enum LocationType {
    plant,
    warehouse,
    distributionCenter,
    port,
    terminal,
    customerSite,
    supplierSite,
    crossDock
}

enum ModelStatus {
    draft,
    active,
    deprecated_
}
