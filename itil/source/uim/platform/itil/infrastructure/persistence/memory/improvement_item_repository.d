/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.memory.memory_improvement_item_repository;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryImprovementItemRepository : ImprovementItemRepository {
    private ImprovementItem[] store;

    ImprovementItem[] findAll() { return store.dup; }

    ImprovementItem* findById(ImprovementItemId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    ImprovementItem[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    ImprovementItem[] findByStatus(ImprovementStatus improvementStatus) {
        return store.filter!(s => s.improvementStatus == improvementStatus).array;
    }

    ImprovementItem[] findByPriority(Priority priority) {
        return store.filter!(s => s.priority == priority).array;
    }

    ImprovementItem[] findByService(ITServiceId serviceId) {
        return store.filter!(s => s.relatedServiceId == serviceId).array;
    }

    void save(ImprovementItem s) { store ~= s; }

    void update(ImprovementItem s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(ImprovementItemId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
