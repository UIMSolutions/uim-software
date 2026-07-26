/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.repositories.platforms;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryPlatformRepository : PlatformRepository {
    private LeanPlatform[] store;

    LeanPlatform[] findAll() { return store; }

    LeanPlatform* findById(PlatformId id) {
        foreach (ref p; store) if (p.id == id) return &p;
        return null;
    }

    LeanPlatform[] findByTenant(TenantId tenantId) {
        LeanPlatform[] result;
        foreach (ref p; store) if (p.tenantId == tenantId) result ~= p;
        return result;
    }

    LeanPlatform[] findByStatus(FactSheetStatus status) {
        LeanPlatform[] result;
        foreach (ref p; store) if (p.status == status) result ~= p;
        return result;
    }

    void save(LeanPlatform leanPlatform) { store ~= leanPlatform; }

    void update(LeanPlatform leanPlatform) {
        foreach (ref p; store) if (p.id == leanPlatform.id) { p = leanPlatform; return; }
    }

    void remove(PlatformId id) {
        import std.algorithm : remove;
        store = store.remove!(p => p.id == id);
    }
}
