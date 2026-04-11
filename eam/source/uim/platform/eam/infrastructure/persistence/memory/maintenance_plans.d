/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.infrastructure.persistence.memory.maintenance_plans;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class MemoryMaintenancePlanRepository : MaintenancePlanRepository {
    private MaintenancePlan[] store;

    MaintenancePlan[] findAll() { return store; }

    MaintenancePlan* findById(MaintenancePlanId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    MaintenancePlan[] findByTenant(TenantId tenantId) {
        MaintenancePlan[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    MaintenancePlan[] findByStatus(PlanStatus status) {
        MaintenancePlan[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    MaintenancePlan[] findByCategory(PlanCategory category) {
        MaintenancePlan[] result;
        foreach (ref e; store)
            if (e.category == category) result ~= e;
        return result;
    }

    void save(MaintenancePlan plan) { store ~= plan; }

    void update(MaintenancePlan plan) {
        foreach (ref e; store)
            if (e.id == plan.id) { e = plan; return; }
    }

    void remove(MaintenancePlanId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
