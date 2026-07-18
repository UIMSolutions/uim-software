module uim.platform.defemse.domain.repositories.budget_triggers;

import uim.platform.defemse.domain.entities.budget_trigger;
import uim.platform.defemse.domain.types;

@safe:

interface BudgetTriggerRepository {
    BudgetTrigger[] findAll();
    BudgetTrigger* findById(BudgetTriggerId id);
    void save(BudgetTrigger trigger);
    void update(BudgetTrigger trigger);
    void remove(BudgetTriggerId id);
}