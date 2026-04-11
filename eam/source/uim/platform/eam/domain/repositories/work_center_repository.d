/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.repositories.work_center_repository;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

interface WorkCenterRepository {
    WorkCenter[] findAll();
    WorkCenter* findById(WorkCenterId id);
    WorkCenter[] findByTenant(TenantId tenantId);
    WorkCenter[] findByCategory(WorkCenterCategory category);
    void save(WorkCenter workCenter);
    void update(WorkCenter workCenter);
    void remove(WorkCenterId id);
}
