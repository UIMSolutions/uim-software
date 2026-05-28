/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.improvement_item;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ImprovementItem {
    ImprovementItemId id;
    TenantId tenantId;
    string title;
    string description;
    ImprovementStatus improvementStatus = ImprovementStatus.identified;
    Priority priority = Priority.medium;
    string category;
    string proposedBy;
    string owner;
    string targetDate;
    string completedDate;
    string expectedBenefit;
    string actualBenefit;
    ITServiceId relatedServiceId;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
