/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.infrastructure.persistence.memory.floating_ips;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class MemoryFloatingIpRepository : FloatingIpRepository {
    private FloatingIp[] store;

    FloatingIp[] findAll() { return store; }

    FloatingIp* findById(FloatingIpId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    FloatingIp[] findByTenant(TenantId tenantId) {
        FloatingIp[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    FloatingIp[] findByStatus(FloatingIpStatus status) {
        FloatingIp[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    FloatingIp[] findByInstance(InstanceId instanceId) {
        FloatingIp[] result;
        foreach (ref e; store)
            if (e.instanceId == instanceId) result ~= e;
        return result;
    }

    void save(FloatingIp floatingIp) { store ~= floatingIp; }

    void update(FloatingIp floatingIp) {
        foreach (ref e; store)
            if (e.id == floatingIp.id) { e = floatingIp; return; }
    }

    void remove(FloatingIpId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
