/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.infrastructure.persistence.memory.volumes;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class MemoryVolumeRepository : VolumeRepository {
    private Volume[] store;

    Volume[] findAll() { return store; }

    Volume* findById(VolumeId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Volume[] findByTenant(TenantId tenantId) {
        Volume[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    Volume[] findByStatus(VolumeStatus status) {
        Volume[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    Volume[] findByInstance(InstanceId instanceId) {
        Volume[] result;
        foreach (ref e; store)
            if (e.instanceId == instanceId) result ~= e;
        return result;
    }

    void save(Volume volume) { store ~= volume; }

    void update(Volume volume) {
        foreach (ref e; store)
            if (e.id == volume.id) { e = volume; return; }
    }

    void remove(VolumeId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
