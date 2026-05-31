module uim.platform.ps.domain.repositories.project_cost_repository;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

interface ProjectCostRepository {
    ProjectCost[] findAll();
    ProjectCost* findById(ProjectCostId id);
    ProjectCost[] findByTenant(TenantId tenantId);
    ProjectCost[] findByProject(ProjectId projectId);
    ProjectCost[] findByWBSElement(WBSElementId wbsElementId);
    void save(ProjectCost cost);
    void update(ProjectCost cost);
    void remove(ProjectCostId id);
}
