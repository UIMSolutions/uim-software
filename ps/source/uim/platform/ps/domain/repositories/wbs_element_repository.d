module uim.platform.ps.domain.repositories.wbs_element_repository;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

interface WBSElementRepository {
    WBSElement[] findAll();
    WBSElement* findById(WBSElementId id);
    WBSElement[] findByTenant(TenantId tenantId);
    WBSElement[] findByProject(ProjectId projectId);
    WBSElement[] findByParent(WBSElementId parentId);
    void save(WBSElement element);
    void update(WBSElement element);
    void remove(WBSElementId id);
}
