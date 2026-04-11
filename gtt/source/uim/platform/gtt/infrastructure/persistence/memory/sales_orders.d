/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.persistence.memory.sales_orders;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class MemorySalesOrderRepository : SalesOrderRepository {
    private SalesOrder[] store;

    SalesOrder[] findAll() { return store; }

    SalesOrder* findById(SalesOrderId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    SalesOrder[] findByTenant(TenantId tenantId) {
        SalesOrder[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    SalesOrder[] findByStatus(SalesOrderStatus status) {
        SalesOrder[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    SalesOrder[] findByCustomer(string customerId) {
        SalesOrder[] result;
        foreach (ref e; store)
            if (e.customerId == customerId) result ~= e;
        return result;
    }

    void save(SalesOrder order) { store ~= order; }

    void update(SalesOrder order) {
        foreach (ref e; store)
            if (e.id == order.id) { e = order; return; }
    }

    void remove(SalesOrderId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
