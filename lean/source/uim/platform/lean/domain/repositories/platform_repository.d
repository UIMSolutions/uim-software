/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.platform_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface PlatformRepository {
    LeanPlatform[] findAll();
    LeanPlatform* findById(PlatformId id);
    LeanPlatform[] findByTenant(TenantId tenantId);
    LeanPlatform[] findByStatus(FactSheetStatus status);
    void save(LeanPlatform leanPlatform);
    void update(LeanPlatform leanPlatform);
    void remove(PlatformId id);
}
