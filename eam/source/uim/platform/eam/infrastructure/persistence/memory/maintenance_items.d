/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.infrastructure.persistence.memory.maintenance_items;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class MemoryMaintenanceItemRepository : MaintenanceItemRepository {
    private MaintenanceItem[] store;

    MaintenanceItem[] findAll() { return store; }

    MaintenanceItem* findById(MaintenanceItemId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    MaintenanceItem[] findByTenant(TenantId tenantId) {
        MaintenanceItem[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    MaintenanceItem[] findByPlan(MaintenancePlanId planId) {
        MaintenanceItem[] result;
        foreach (ref e; store)
            if (e.maintenancePlanId == planId) result ~= e;
        return result;
    }

    MaintenanceItem[] findByEquipment(EquipmentId equipmentId) {
        MaintenanceItem[] result;
        foreach (ref e; store)
            if (e.equipmentId == equipmentId) result ~= e;
        return result;
    }

    void save(MaintenanceItem item) { store ~= item; }

    void update(MaintenanceItem item) {
        foreach (ref e; store)
            if (e.id == item.id) { e = item; return; }
    }

    void remove(MaintenanceItemId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
