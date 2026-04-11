/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.persistence.memory.shipments;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class MemoryShipmentRepository : ShipmentRepository {
    private Shipment[] store;

    Shipment[] findAll() { return store; }

    Shipment* findById(ShipmentId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Shipment[] findByTenant(TenantId tenantId) {
        Shipment[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    Shipment[] findByStatus(ShipmentStatus status) {
        Shipment[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    Shipment[] findByCarrier(string carrierName) {
        Shipment[] result;
        foreach (ref e; store)
            if (e.carrierName == carrierName) result ~= e;
        return result;
    }

    void save(Shipment shipment) { store ~= shipment; }

    void update(Shipment shipment) {
        foreach (ref e; store)
            if (e.id == shipment.id) { e = shipment; return; }
    }

    void remove(ShipmentId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
