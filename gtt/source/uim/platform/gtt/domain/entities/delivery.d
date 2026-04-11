/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.entities.delivery;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct Delivery {
    DeliveryId id;
    TenantId tenantId;
    string name;
    string description;
    string deliveryNumber;
    DeliveryType deliveryType = DeliveryType.outbound;
    DeliveryStatus status = DeliveryStatus.created;
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
