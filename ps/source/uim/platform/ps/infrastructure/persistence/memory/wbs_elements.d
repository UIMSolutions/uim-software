module uim.platform.ps.infrastructure.persistence.repositories.wbs_elements;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class MemoryWBSElementRepository : WBSElementRepository {
    private WBSElement[] store;

    WBSElement[] findAll() { return store; }

    WBSElement* findById(WBSElementId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    WBSElement[] findByTenant(TenantId tenantId) {
        WBSElement[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    WBSElement[] findByProject(ProjectId projectId) {
        WBSElement[] result;
        foreach (ref e; store)
            if (e.projectId == projectId) result ~= e;
        return result;
    }

    WBSElement[] findByParent(WBSElementId parentId) {
        WBSElement[] result;
        foreach (ref e; store)
            if (e.parentId == parentId) result ~= e;
        return result;
    }

    void save(WBSElement element) { store ~= element; }

    void update(WBSElement element) {
        foreach (ref e; store)
            if (e.id == element.id) { e = element; return; }
    }

    void remove(WBSElementId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
