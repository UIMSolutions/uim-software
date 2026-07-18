/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.repositories.incidents;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryIncidentRepository : IncidentRepository {
    private Incident[] store;

    Incident[] findAll() { return store.dup; }

    Incident* findById(IncidentId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    Incident[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    Incident[] findByStatus(RecordStatus status) {
        return store.filter!(s => s.status == status).array;
    }

    Incident[] findByPriority(Priority priority) {
        return store.filter!(s => s.priority == priority).array;
    }

    Incident[] findByService(ITServiceId serviceId) {
        return store.filter!(s => s.affectedServiceId == serviceId).array;
    }

    void save(Incident s) { store ~= s; }

    void update(Incident s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(IncidentId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
