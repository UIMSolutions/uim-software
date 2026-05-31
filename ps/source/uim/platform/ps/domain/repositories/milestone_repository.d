module uim.platform.ps.domain.repositories.milestone_repository;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

interface MilestoneRepository {
    Milestone[] findAll();
    Milestone* findById(MilestoneId id);
    Milestone[] findByTenant(TenantId tenantId);
    Milestone[] findByProject(ProjectId projectId);
    void save(Milestone milestone);
    void update(Milestone milestone);
    void remove(MilestoneId id);
}
