/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.lean_application_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface LeanApplicationRepository {
    LeanApplication[] findAll();
    LeanApplication* findById(LeanApplicationId id);
    LeanApplication[] findByTenant(TenantId tenantId);
    LeanApplication[] findByStatus(FactSheetStatus status);
    LeanApplication[] findByLifecycleStatus(ApplicationLifecycleStatus lifecycleStatus);
    LeanApplication[] findByType(ApplicationType applicationType);
    LeanApplication[] findByOrganization(OrganizationId orgId);
    void save(LeanApplication app);
    void update(LeanApplication app);
    void remove(LeanApplicationId id);
}
