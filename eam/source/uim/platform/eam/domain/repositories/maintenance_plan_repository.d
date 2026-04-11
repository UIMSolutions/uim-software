/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.repositories.maintenance_plan_repository;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

interface MaintenancePlanRepository {
    MaintenancePlan[] findAll();
    MaintenancePlan* findById(MaintenancePlanId id);
    MaintenancePlan[] findByTenant(TenantId tenantId);
    MaintenancePlan[] findByStatus(PlanStatus status);
    MaintenancePlan[] findByCategory(PlanCategory category);
    void save(MaintenancePlan plan);
    void update(MaintenancePlan plan);
    void remove(MaintenancePlanId id);
}
