/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.entities.maintenance_plan;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct MaintenancePlan {
    MaintenancePlanId id;
    TenantId tenantId;
    string name;
    string description;
    PlanCategory category = PlanCategory.timeBased;
    PlanStatus status = PlanStatus.active;
    string cycleLength;
    string cycleUnit;
    string leadTimeOffset;
    string schedulingPeriod;
    string lastScheduledDate;
    string nextDueDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
