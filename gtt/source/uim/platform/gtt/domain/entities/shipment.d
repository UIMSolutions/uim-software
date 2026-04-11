/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.entities.shipment;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct Shipment {
    ShipmentId id;
    TenantId tenantId;
    string name;
    string description;
    string shipmentNumber;
    string carrierName;
    string carrierTrackingId;
    TransportMode transportMode = TransportMode.road;
    ShipmentStatus status = ShipmentStatus.created;
    string originLocationId;
    string destinationLocationId;
    string plannedDeparture;
    string plannedArrival;
    string actualDeparture;
    string actualArrival;
    string waypoints;
    string trackingModelId;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
