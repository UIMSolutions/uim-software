/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.memory.providers;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryProviderRepository : ProviderRepository {
    private Provider[] store;

    Provider[] findAll() { return store; }

    Provider* findById(ProviderId id) {
        foreach (ref p; store) if (p.id == id) return &p;
        return null;
    }

    Provider[] findByTenant(TenantId tenantId) {
        Provider[] result;
        foreach (ref p; store) if (p.tenantId == tenantId) result ~= p;
        return result;
    }

    Provider[] findByStatus(FactSheetStatus status) {
        Provider[] result;
        foreach (ref p; store) if (p.status == status) result ~= p;
        return result;
    }

    void save(Provider provider) { store ~= provider; }

    void update(Provider provider) {
        foreach (ref p; store) if (p.id == provider.id) { p = provider; return; }
    }

    void remove(ProviderId id) {
        import std.algorithm : remove;
        store = store.remove!(p => p.id == id);
    }
}
