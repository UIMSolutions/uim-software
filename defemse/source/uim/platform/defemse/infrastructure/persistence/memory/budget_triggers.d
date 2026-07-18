module uim.platform.defemse.infrastructure.persistence.repositories.budget_triggers;

import uim.platform.defemse;

@safe:

class MemoryBudgetTriggerRepository : BudgetTriggerRepository {
    private BudgetTrigger[] items;

    BudgetTrigger[] findAll() { return items.dup; }

    BudgetTrigger* findById(BudgetTriggerId id) {
        foreach (ref item; items) if (item.id == id) return &item;
        return null;
    }

    void save(BudgetTrigger trigger) { items ~= trigger; }

    void update(BudgetTrigger trigger) {
        foreach (index, ref item; items) if (item.id == trigger.id) { items[index] = trigger; return; }
    }

    void remove(BudgetTriggerId id) {
        BudgetTrigger[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}