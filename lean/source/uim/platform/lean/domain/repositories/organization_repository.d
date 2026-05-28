/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.organization_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface OrganizationRepository {
    Organization[] findAll();
    Organization* findById(OrganizationId id);
    Organization[] findByTenant(TenantId tenantId);
    Organization[] findByStatus(FactSheetStatus status);
    Organization[] findByParent(OrganizationId parentOrgId);
    void save(Organization organization);
    void update(Organization organization);
    void remove(OrganizationId id);
}
