/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.repositories.sales_order_repository;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

interface SalesOrderRepository {
    SalesOrder[] findAll();
    SalesOrder* findById(SalesOrderId id);
    SalesOrder[] findByTenant(TenantId tenantId);
    SalesOrder[] findByStatus(SalesOrderStatus status);
    SalesOrder[] findByCustomer(string customerId);
    void save(SalesOrder order);
    void update(SalesOrder order);
    void remove(SalesOrderId id);
}
