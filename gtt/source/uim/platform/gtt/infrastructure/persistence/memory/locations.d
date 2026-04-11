/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.persistence.memory.locations;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class MemoryLocationRepository : LocationRepository {
    private Location[] store;

    Location[] findAll() { return store; }

    Location* findById(LocationId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Location[] findByTenant(TenantId tenantId) {
        Location[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    Location[] findByType(LocationType locationType) {
        Location[] result;
        foreach (ref e; store)
            if (e.locationType == locationType) result ~= e;
        return result;
    }

    Location[] findByCountry(string country) {
        Location[] result;
        foreach (ref e; store)
            if (e.country == country) result ~= e;
        return result;
    }

    void save(Location location) { store ~= location; }

    void update(Location location) {
        foreach (ref e; store)
            if (e.id == location.id) { e = location; return; }
    }

    void remove(LocationId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
