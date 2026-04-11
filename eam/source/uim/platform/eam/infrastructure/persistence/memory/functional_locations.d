/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.infrastructure.persistence.memory.functional_locations;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class MemoryFunctionalLocationRepository : FunctionalLocationRepository {
    private FunctionalLocation[] store;

    FunctionalLocation[] findAll() { return store; }

    FunctionalLocation* findById(FunctionalLocationId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    FunctionalLocation[] findByTenant(TenantId tenantId) {
        FunctionalLocation[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    FunctionalLocation[] findByType(FunctionalLocationType locationType) {
        FunctionalLocation[] result;
        foreach (ref e; store)
            if (e.locationType == locationType) result ~= e;
        return result;
    }

    FunctionalLocation[] findByParent(FunctionalLocationId parentId) {
        FunctionalLocation[] result;
        foreach (ref e; store)
            if (e.parentLocationId == parentId) result ~= e;
        return result;
    }

    void save(FunctionalLocation location) { store ~= location; }

    void update(FunctionalLocation location) {
        foreach (ref e; store)
            if (e.id == location.id) { e = location; return; }
    }

    void remove(FunctionalLocationId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
