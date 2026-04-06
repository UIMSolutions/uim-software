/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.infrastructure.persistence.memory.networks;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class MemoryNetworkRepository : NetworkRepository {
    private Network[] store;

    Network[] findAll() { return store; }

    Network* findById(NetworkId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Network[] findByTenant(TenantId tenantId) {
        Network[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    Network[] findByType(NetworkType networkType) {
        Network[] result;
        foreach (ref e; store)
            if (e.networkType == networkType) result ~= e;
        return result;
    }

    Network[] findByStatus(NetworkStatus status) {
        Network[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    void save(Network network) { store ~= network; }

    void update(Network network) {
        foreach (ref e; store)
            if (e.id == network.id) { e = network; return; }
    }

    void remove(NetworkId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
