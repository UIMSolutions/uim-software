/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ps.domain.types;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

alias ProjectId = string;
alias WBSElementId = string;
alias NetworkActivityId = string;
alias MilestoneId = string;
alias ProjectCostId = string;
alias ProjectBudgetId = string;
alias TenantId = string;
alias UserId = string;

enum ProjectType {
    customerProject,
    overheadCostProject,
    capitalInvestmentProject,
    maintenanceProject
}

enum ProjectStatus {
    created,
    released,
    technically_completed,
    closed,
    locked
}

enum WBSElementType {
    accountAssignment,
    planningElement,
    billingElement,
    summaryElement
}

enum WBSElementStatus {
    created,
    released,
    technically_completed,
    closed
}

enum ActivityType {
    internalProcessing,
    externalProcessing,
    generalCosts,
    serviceActivity
}

enum ActivityStatus {
    created,
    released,
    confirmed,
    technically_completed,
    closed
}

enum MilestoneCategory {
    project_,
    billingMilestone,
    paymentMilestone
}

enum CostCategory {
    labor,
    material,
    external,
    overhead,
    travel,
    other
}

enum BudgetStatus {
    planned,
    approved,
    released,
    locked
}

enum BillingType {
    fixedPrice,
    timeAndMaterial,
    milestone,
    progressBilling
}
