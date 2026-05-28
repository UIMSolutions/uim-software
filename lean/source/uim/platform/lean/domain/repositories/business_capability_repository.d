/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.business_capability_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface BusinessCapabilityRepository {
    BusinessCapability[] findAll();
    BusinessCapability* findById(BusinessCapabilityId id);
    BusinessCapability[] findByTenant(TenantId tenantId);
    BusinessCapability[] findByStatus(FactSheetStatus status);
    BusinessCapability[] findByParent(BusinessCapabilityId parentId);
    BusinessCapability[] findByOrganization(OrganizationId orgId);
    void save(BusinessCapability capability);
    void update(BusinessCapability capability);
    void remove(BusinessCapabilityId id);
}
