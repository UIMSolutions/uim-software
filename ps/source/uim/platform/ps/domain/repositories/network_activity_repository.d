module uim.platform.ps.domain.repositories.network_activity_repository;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

interface NetworkActivityRepository {
    NetworkActivity[] findAll();
    NetworkActivity* findById(NetworkActivityId id);
    NetworkActivity[] findByTenant(TenantId tenantId);
    NetworkActivity[] findByProject(ProjectId projectId);
    NetworkActivity[] findByWBSElement(WBSElementId wbsElementId);
    void save(NetworkActivity activity);
    void update(NetworkActivity activity);
    void remove(NetworkActivityId id);
}
