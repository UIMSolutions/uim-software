/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ps.domain.entities.network_activity;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

struct NetworkActivity {
    NetworkActivityId id;
    TenantId tenantId;
    ProjectId projectId;
    WBSElementId wbsElementId;
    string activityNumber;
    string name;
    string description;
    ActivityType activityType = ActivityType.internalProcessing;
    ActivityStatus status = ActivityStatus.created;
    string workCenter;
    string controlKey;
    string plannedWork;
    string actualWork;
    string remainingWork;
    string plannedStartDate;
    string plannedFinishDate;
    string actualStartDate;
    string actualFinishDate;
    string plannedCost;
    string actualCost;
    string currency;
    string[] predecessors;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
