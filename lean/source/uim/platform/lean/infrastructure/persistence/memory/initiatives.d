/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.memory.initiatives;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryInitiativeRepository : InitiativeRepository {
    private Initiative[] store;

    Initiative[] findAll() { return store; }

    Initiative* findById(InitiativeId id) {
        foreach (ref i; store) if (i.id == id) return &i;
        return null;
    }

    Initiative[] findByTenant(TenantId tenantId) {
        Initiative[] result;
        foreach (ref i; store) if (i.tenantId == tenantId) result ~= i;
        return result;
    }

    Initiative[] findByStatus(FactSheetStatus status) {
        Initiative[] result;
        foreach (ref i; store) if (i.status == status) result ~= i;
        return result;
    }

    Initiative[] findByInitiativeStatus(InitiativeStatus initiativeStatus) {
        Initiative[] result;
        foreach (ref i; store) if (i.initiativeStatus == initiativeStatus) result ~= i;
        return result;
    }

    Initiative[] findByPhase(InitiativePhase phase) {
        Initiative[] result;
        foreach (ref i; store) if (i.phase == phase) result ~= i;
        return result;
    }

    void save(Initiative initiative) { store ~= initiative; }

    void update(Initiative initiative) {
        foreach (ref i; store) if (i.id == initiative.id) { i = initiative; return; }
    }

    void remove(InitiativeId id) {
        import std.algorithm : remove;
        store = store.remove!(i => i.id == id);
    }
}
