/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ps.domain.entities.project;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

struct Project {
    ProjectId id;
    TenantId tenantId;
    string projectDefinition;
    string name;
    string description;
    ProjectType projectType = ProjectType.overheadCostProject;
    ProjectStatus status = ProjectStatus.created;
    string companyCode;
    string controllingArea;
    string profitCenter;
    string responsiblePerson;
    string projectManager;
    string plannedStartDate;
    string plannedFinishDate;
    string actualStartDate;
    string actualFinishDate;
    BillingType billingType = BillingType.timeAndMaterial;
    string currency;
    string totalPlannedCost;
    string totalActualCost;
    string totalBudget;
    string projectProfile;
    string network;
    bool budgetControlActive;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
