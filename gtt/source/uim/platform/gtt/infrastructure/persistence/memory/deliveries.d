/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.persistence.memory.deliveries;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class MemoryDeliveryRepository : DeliveryRepository {
    private Delivery[] store;

    Delivery[] findAll() { return store; }

    Delivery* findById(DeliveryId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Delivery[] findByTenant(TenantId tenantId) {
        Delivery[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    Delivery[] findByStatus(DeliveryStatus status) {
        Delivery[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    Delivery[] findByShipment(ShipmentId shipmentId) {
        Delivery[] result;
        foreach (ref e; store)
            if (e.shipmentId == shipmentId) result ~= e;
        return result;
    }

    void save(Delivery delivery) { store ~= delivery; }

    void update(Delivery delivery) {
        foreach (ref e; store)
            if (e.id == delivery.id) { e = delivery; return; }
    }

    void remove(DeliveryId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
