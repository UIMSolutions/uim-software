/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.memory.memory_it_service_repository;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryITServiceRepository : ITServiceRepository {
    private ITService[] store;

    ITService[] findAll() { return store.dup; }

    ITService* findById(ITServiceId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    ITService[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    ITService[] findByStatus(RecordStatus status) {
        return store.filter!(s => s.status == status).array;
    }

    ITService[] findByOwner(string owner) {
        return store.filter!(s => s.serviceOwner == owner).array;
    }

    void save(ITService s) { store ~= s; }

    void update(ITService s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(ITServiceId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
