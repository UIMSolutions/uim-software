/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.infrastructure.persistence.memory.work_centers;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class MemoryWorkCenterRepository : WorkCenterRepository {
    private WorkCenter[] store;

    WorkCenter[] findAll() { return store; }

    WorkCenter* findById(WorkCenterId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    WorkCenter[] findByTenant(TenantId tenantId) {
        WorkCenter[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    WorkCenter[] findByCategory(WorkCenterCategory category) {
        WorkCenter[] result;
        foreach (ref e; store)
            if (e.category == category) result ~= e;
        return result;
    }

    void save(WorkCenter workCenter) { store ~= workCenter; }

    void update(WorkCenter workCenter) {
        foreach (ref e; store)
            if (e.id == workCenter.id) { e = workCenter; return; }
    }

    void remove(WorkCenterId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
