/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ps.domain.entities.wbs_element;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

struct WBSElement {
    WBSElementId id;
    TenantId tenantId;
    ProjectId projectId;
    WBSElementId parentId;
    string wbsCode;
    string name;
    string description;
    WBSElementType elementType = WBSElementType.planningElement;
    WBSElementStatus status = WBSElementStatus.created;
    int level;
    bool isAccountAssignment;
    bool isPlanningElement;
    bool isBillingElement;
    string responsiblePerson;
    string workCenter;
    string profitCenter;
    string costCenter;
    string plannedStartDate;
    string plannedFinishDate;
    string actualStartDate;
    string actualFinishDate;
    string plannedCost;
    string actualCost;
    string currency;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
