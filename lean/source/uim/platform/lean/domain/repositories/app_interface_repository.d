/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.app_interface_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface AppInterfaceRepository {
    AppInterface[] findAll();
    AppInterface findById(AppInterfaceId id);
    AppInterface[] findByTenant(TenantId tenantId);
    AppInterface[] findByStatus(FactSheetStatus status);
    AppInterface[] findBySourceApplication(LeanApplicationId appId);
    AppInterface[] findByTargetApplication(LeanApplicationId appId);
    void save(AppInterface appInterface);
    void update(AppInterface appInterface);
    void remove(AppInterfaceId id);
}
