module uim.platform.defense.domain.repositories.budget_triggers;

import uim.platform.defense.domain.entities.budget_trigger;
import uim.platform.defense.domain.types;

@safe:

interface BudgetTriggerRepository {
    BudgetTrigger[] findAll();
    BudgetTrigger* findById(BudgetTriggerId id);
    void save(BudgetTrigger trigger);
    void update(BudgetTrigger trigger);
    void remove(BudgetTriggerId id);
}