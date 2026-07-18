/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.memory.change_record_repository;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryChangeRecordRepository : ChangeRecordRepository {
    private ChangeRecord[] store;

    ChangeRecord[] findAll() { return store.dup; }

    ChangeRecord* findById(ChangeRecordId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    ChangeRecord[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    ChangeRecord[] findByStatus(ChangeStatus changeStatus) {
        return store.filter!(s => s.changeStatus == changeStatus).array;
    }

    ChangeRecord[] findByType(ChangeType changeType) {
        return store.filter!(s => s.changeType == changeType).array;
    }

    ChangeRecord[] findByRisk(ChangeRisk risk) {
        return store.filter!(s => s.risk == risk).array;
    }

    void save(ChangeRecord s) { store ~= s; }

    void update(ChangeRecord s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(ChangeRecordId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
