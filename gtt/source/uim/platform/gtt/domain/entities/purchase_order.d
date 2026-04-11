/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.entities.purchase_order;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct PurchaseOrder {
    PurchaseOrderId id;
    TenantId tenantId;
    string name;
    string description;
    string orderNumber;
    PurchaseOrderStatus status = PurchaseOrderStatus.created;
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
