/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.repositories.objectives;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryObjectiveRepository : ObjectiveRepository {
    private Objective[] store;

    Objective[] findAll() { return store; }

    Objective* findById(ObjectiveId id) {
        foreach (ref o; store) if (o.id == id) return &o;
        return null;
    }

    Objective[] findByTenant(TenantId tenantId) {
        Objective[] result;
        foreach (ref o; store) if (o.tenantId == tenantId) result ~= o;
        return result;
    }

    Objective[] findByStatus(FactSheetStatus status) {
        Objective[] result;
        foreach (ref o; store) if (o.status == status) result ~= o;
        return result;
    }

    Objective[] findByType(ObjectiveType objectiveType) {
        Objective[] result;
        foreach (ref o; store) if (o.objectiveType == objectiveType) result ~= o;
        return result;
    }

    void save(Objective objective) { store ~= objective; }

    void update(Objective objective) {
        foreach (ref o; store) if (o.id == objective.id) { o = objective; return; }
    }

    void remove(ObjectiveId id) {
        import std.algorithm : remove;
        store = store.remove!(o => o.id == id);
    }
}
