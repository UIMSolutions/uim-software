/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.repositories.incident_repository;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

interface IncidentRepository {
    Incident[] findAll();
    Incident* findById(IncidentId id);
    Incident[] findByTenant(TenantId tenantId);
    Incident[] findBySeverity(IncidentSeverity severity);
    Incident[] findByStatus(IncidentStatus status);
    void save(Incident incident);
    void update(Incident incident);
    void remove(IncidentId id);
}
