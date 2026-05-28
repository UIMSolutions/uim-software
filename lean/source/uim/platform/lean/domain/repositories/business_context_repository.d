/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.business_context_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface BusinessContextRepository {
    BusinessContext[] findAll();
    BusinessContext* findById(BusinessContextId id);
    BusinessContext[] findByTenant(TenantId tenantId);
    BusinessContext[] findByStatus(FactSheetStatus status);
    BusinessContext[] findByCapability(BusinessCapabilityId capabilityId);
    void save(BusinessContext context);
    void update(BusinessContext context);
    void remove(BusinessContextId id);
}
