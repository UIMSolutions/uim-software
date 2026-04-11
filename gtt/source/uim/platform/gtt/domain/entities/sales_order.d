/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.entities.sales_order;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct SalesOrder {
    SalesOrderId id;
    TenantId tenantId;
    string name;
    string description;
    string orderNumber;
    SalesOrderStatus status = SalesOrderStatus.accepted;
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
