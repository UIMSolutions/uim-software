/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.infrastructure.persistence.memory.maintenance_orders;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class MemoryMaintenanceOrderRepository : MaintenanceOrderRepository {
    private MaintenanceOrder[] store;

    MaintenanceOrder[] findAll() { return store; }

    MaintenanceOrder* findById(MaintenanceOrderId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    MaintenanceOrder[] findByTenant(TenantId tenantId) {
        MaintenanceOrder[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    MaintenanceOrder[] findByStatus(OrderStatus status) {
        MaintenanceOrder[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    MaintenanceOrder[] findByEquipment(EquipmentId equipmentId) {
        MaintenanceOrder[] result;
        foreach (ref e; store)
            if (e.equipmentId == equipmentId) result ~= e;
        return result;
    }

    MaintenanceOrder[] findByType(OrderType orderType) {
        MaintenanceOrder[] result;
        foreach (ref e; store)
            if (e.orderType == orderType) result ~= e;
        return result;
    }

    void save(MaintenanceOrder order) { store ~= order; }

    void update(MaintenanceOrder order) {
        foreach (ref e; store)
            if (e.id == order.id) { e = order; return; }
    }

    void remove(MaintenanceOrderId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
