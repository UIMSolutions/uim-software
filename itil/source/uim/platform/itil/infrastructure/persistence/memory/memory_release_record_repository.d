/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.memory.memory_release_record_repository;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryReleaseRecordRepository : ReleaseRecordRepository {
    private ReleaseRecord[] store;

    ReleaseRecord[] findAll() { return store.dup; }

    ReleaseRecord* findById(ReleaseRecordId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    ReleaseRecord[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    ReleaseRecord[] findByStatus(ReleaseStatus releaseStatus) {
        return store.filter!(s => s.releaseStatus == releaseStatus).array;
    }

    ReleaseRecord[] findByType(ReleaseType releaseType) {
        return store.filter!(s => s.releaseType == releaseType).array;
    }

    void save(ReleaseRecord s) { store ~= s; }

    void update(ReleaseRecord s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(ReleaseRecordId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
