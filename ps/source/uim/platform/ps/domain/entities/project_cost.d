/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ps.domain.entities.project_cost;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

struct ProjectCost {
    ProjectCostId id;
    TenantId tenantId;
    ProjectId projectId;
    WBSElementId wbsElementId;
    NetworkActivityId activityId;
    CostCategory costCategory = CostCategory.labor;
    string costElement;
    string plannedCost;
    string actualCost;
    string committedCost;
    string remainingCost;
    string currency;
    string fiscalYear;
    string period;
    string postingDate;
    string documentNumber;
    string description;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
