/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.persistence.memory.purchase_orders;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class MemoryPurchaseOrderRepository : PurchaseOrderRepository {
    private PurchaseOrder[] store;

    PurchaseOrder[] findAll() { return store; }

    PurchaseOrder* findById(PurchaseOrderId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    PurchaseOrder[] findByTenant(TenantId tenantId) {
        PurchaseOrder[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    PurchaseOrder[] findByStatus(PurchaseOrderStatus status) {
        PurchaseOrder[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    PurchaseOrder[] findBySupplier(string supplierId) {
        PurchaseOrder[] result;
        foreach (ref e; store)
            if (e.supplierId == supplierId) result ~= e;
        return result;
    }

    void save(PurchaseOrder order) { store ~= order; }

    void update(PurchaseOrder order) {
        foreach (ref e; store)
            if (e.id == order.id) { e = order; return; }
    }

    void remove(PurchaseOrderId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
