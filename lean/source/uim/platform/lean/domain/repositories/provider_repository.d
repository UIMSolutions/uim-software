/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.provider_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface ProviderRepository {
    Provider[] findAll();
    Provider* findById(ProviderId id);
    Provider[] findByTenant(TenantId tenantId);
    Provider[] findByStatus(FactSheetStatus status);
    void save(Provider provider);
    void update(Provider provider);
    void remove(ProviderId id);
}
