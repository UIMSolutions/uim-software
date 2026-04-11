/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.application.dto;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct ShipmentDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string shipmentNumber;
    string carrierName;
    string carrierTrackingId;
    string transportMode;
    string status;
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

struct DeliveryDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string deliveryNumber;
    string deliveryType;
    string status;
    string shipmentId;
    string purchaseOrderId;
    string salesOrderId;
    string originLocationId;
    string destinationLocationId;
    string carrierReference;
    string items;
    string plannedDate;
    string actualDate;
    string proofOfDelivery;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct PurchaseOrderDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string orderNumber;
    string status;
    string supplierId;
    string buyerLocationId;
    string supplierLocationId;
    string items;
    string orderDate;
    string expectedDeliveryDate;
    string actualDeliveryDate;
    string currency;
    string totalAmount;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct SalesOrderDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string orderNumber;
    string status;
    string customerId;
    string sellerLocationId;
    string customerLocationId;
    string items;
    string orderDate;
    string requestedDeliveryDate;
    string actualDeliveryDate;
    string currency;
    string totalAmount;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct TrackingEventDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string eventType;
    string status;
    string trackedObjectId;
    string trackedObjectType;
    string locationId;
    string latitude;
    string longitude;
    string eventTimestamp;
    string reportedBy;
    string sensorData;
    string milestone;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct TrackedProcessDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string processType;
    string status;
    string trackingModelId;
    string shipmentIds;
    string deliveryIds;
    string purchaseOrderIds;
    string salesOrderIds;
    string currentMilestone;
    string completionPercent;
    string startDate;
    string endDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct LocationDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string locationType;
    string address;
    string city;
    string country;
    string postalCode;
    string latitude;
    string longitude;
    string timezone;
    string sourceSystem;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct TrackingModelDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string trackedObjectType;
    string expectedEvents;
    string milestones;
    string correlationRules;
    string exceptionRules;
    string version_;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
