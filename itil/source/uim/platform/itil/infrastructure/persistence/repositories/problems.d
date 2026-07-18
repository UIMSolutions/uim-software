/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.repositories.problems;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryProblemRepository : ProblemRepository {
    private Problem[] store;

    Problem[] findAll() { return store.dup; }

    Problem* findById(ProblemId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    Problem[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    Problem[] findByStatus(ProblemStatus status) {
        return store.filter!(s => s.problemStatus == status).array;
    }

    Problem[] findByPriority(Priority priority) {
        return store.filter!(s => s.priority == priority).array;
    }

    Problem[] findByService(ITServiceId serviceId) {
        return store.filter!(s => s.affectedServiceId == serviceId).array;
    }

    void save(Problem s) { store ~= s; }

    void update(Problem s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(ProblemId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
