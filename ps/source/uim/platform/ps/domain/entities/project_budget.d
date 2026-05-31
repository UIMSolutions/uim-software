/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ps.domain.entities.project_budget;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

struct ProjectBudget {
    ProjectBudgetId id;
    TenantId tenantId;
    ProjectId projectId;
    WBSElementId wbsElementId;
    BudgetStatus budgetStatus = BudgetStatus.planned;
    string originalBudget;
    string currentBudget;
    string supplementBudget;
    string returnBudget;
    string transferBudget;
    string availableBudget;
    string assignedBudget;
    string currency;
    string fiscalYear;
    string validFrom;
    string validTo;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
