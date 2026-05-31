module uim.platform.ps.application.dto;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

struct ProjectDTO {
    string id;
    string tenantId;
    string projectDefinition;
    string name;
    string description;
    string projectType;
    string status;
    string companyCode;
    string controllingArea;
    string profitCenter;
    string responsiblePerson;
    string projectManager;
    string plannedStartDate;
    string plannedFinishDate;
    string actualStartDate;
    string actualFinishDate;
    string billingType;
    string currency;
    string totalPlannedCost;
    string totalActualCost;
    string totalBudget;
    string projectProfile;
    string network;
    string budgetControlActive;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct WBSElementDTO {
    string id;
    string tenantId;
    string projectId;
    string parentId;
    string wbsCode;
    string name;
    string description;
    string elementType;
    string status;
    string level;
    string isAccountAssignment;
    string isPlanningElement;
    string isBillingElement;
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
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct NetworkActivityDTO {
    string id;
    string tenantId;
    string projectId;
    string wbsElementId;
    string activityNumber;
    string name;
    string description;
    string activityType;
    string status;
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
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct MilestoneDTO {
    string id;
    string tenantId;
    string projectId;
    string wbsElementId;
    string activityId;
    string milestoneNumber;
    string name;
    string description;
    string category;
    string isReached;
    string plannedDate;
    string actualDate;
    string billingAmount;
    string currency;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ProjectCostDTO {
    string id;
    string tenantId;
    string projectId;
    string wbsElementId;
    string activityId;
    string costCategory;
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
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ProjectBudgetDTO {
    string id;
    string tenantId;
    string projectId;
    string wbsElementId;
    string budgetStatus;
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
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
