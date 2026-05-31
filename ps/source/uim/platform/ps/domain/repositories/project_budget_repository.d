module uim.platform.ps.domain.repositories.project_budget_repository;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

interface ProjectBudgetRepository {
    ProjectBudget[] findAll();
    ProjectBudget* findById(ProjectBudgetId id);
    ProjectBudget[] findByTenant(TenantId tenantId);
    ProjectBudget[] findByProject(ProjectId projectId);
    void save(ProjectBudget budget);
    void update(ProjectBudget budget);
    void remove(ProjectBudgetId id);
}
