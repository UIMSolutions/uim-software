/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ps.domain.entities.milestone;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

struct Milestone {
    MilestoneId id;
    TenantId tenantId;
    ProjectId projectId;
    WBSElementId wbsElementId;
    NetworkActivityId activityId;
    string milestoneNumber;
    string name;
    string description;
    MilestoneCategory category = MilestoneCategory.project_;
    bool isReached;
    string plannedDate;
    string actualDate;
    string billingAmount;
    string currency;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
