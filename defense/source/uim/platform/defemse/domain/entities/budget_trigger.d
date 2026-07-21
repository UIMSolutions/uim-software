module uim.platform.defense.domain.entities.budget_trigger;

import uim.platform.defense.domain.types;

@safe:

struct BudgetTrigger {
    BudgetTriggerId id;
    TenantId tenantId;
    MissionPlanId missionPlanId;
    string sourceProcess;
    string amount;
    string currency;
    string triggerReason;
    BudgetTriggerStatus status = BudgetTriggerStatus.requested;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}