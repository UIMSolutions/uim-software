/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.infrastructure.persistence.repositories.incidents;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class MemoryIncidentRepository : IncidentRepository {
    private Incident[] store;

    Incident[] findAll() { return store; }

    Incident* findById(IncidentId id) {
        foreach (ref i; store)
            if (i.id == id) return &i;
        return null;
    }

    Incident[] findByTenant(TenantId tenantId) {
        Incident[] result;
        foreach (ref i; store)
            if (i.tenantId == tenantId) result ~= i;
        return result;
    }

    Incident[] findBySeverity(IncidentSeverity severity) {
        Incident[] result;
        foreach (ref i; store)
            if (i.severity == severity) result ~= i;
        return result;
    }

    Incident[] findByStatus(IncidentStatus status) {
        Incident[] result;
        foreach (ref i; store)
            if (i.status == status) result ~= i;
        return result;
    }

    void save(Incident incident) { store ~= incident; }

    void update(Incident incident) {
        foreach (ref i; store)
            if (i.id == incident.id) { i = incident; return; }
    }

    void remove(IncidentId id) {
        import std.algorithm : remove;
        store = store.remove!(i => i.id == id);
    }
}
