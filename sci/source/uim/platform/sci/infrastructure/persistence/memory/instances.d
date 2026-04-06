/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.infrastructure.persistence.memory.instances;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class MemoryInstanceRepository : InstanceRepository {
    private Instance[] store;

    Instance[] findAll() { return store; }

    Instance* findById(InstanceId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Instance[] findByTenant(TenantId tenantId) {
        Instance[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    Instance[] findByStatus(InstanceStatus status) {
        Instance[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    Instance[] findByAvailabilityZone(string zone) {
        Instance[] result;
        foreach (ref e; store)
            if (e.availabilityZone == zone) result ~= e;
        return result;
    }

    void save(Instance instance) { store ~= instance; }

    void update(Instance instance) {
        foreach (ref e; store)
            if (e.id == instance.id) { e = instance; return; }
    }

    void remove(InstanceId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
