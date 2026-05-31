module uim.platform.ps.domain.repositories.project_repository;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

interface ProjectRepository {
    Project[] findAll();
    Project* findById(ProjectId id);
    Project[] findByTenant(TenantId tenantId);
    void save(Project project);
    void update(Project project);
    void remove(ProjectId id);
}
