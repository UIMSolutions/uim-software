module uim.platform.ps.infrastructure.persistence.repositories.project_budgets;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class MemoryProjectBudgetRepository : ProjectBudgetRepository {
    private ProjectBudget[] store;

    ProjectBudget[] findAll() { return store; }

    ProjectBudget* findById(ProjectBudgetId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    ProjectBudget[] findByTenant(TenantId tenantId) {
        ProjectBudget[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    ProjectBudget[] findByProject(ProjectId projectId) {
        ProjectBudget[] result;
        foreach (ref e; store)
            if (e.projectId == projectId) result ~= e;
        return result;
    }

    void save(ProjectBudget budget) { store ~= budget; }

    void update(ProjectBudget budget) {
        foreach (ref e; store)
            if (e.id == budget.id) { e = budget; return; }
    }

    void remove(ProjectBudgetId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
