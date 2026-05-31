module uim.platform.ps.infrastructure.persistence.memory.network_activities;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class MemoryNetworkActivityRepository : NetworkActivityRepository {
    private NetworkActivity[] store;

    NetworkActivity[] findAll() { return store; }

    NetworkActivity* findById(NetworkActivityId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    NetworkActivity[] findByTenant(TenantId tenantId) {
        NetworkActivity[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    NetworkActivity[] findByProject(ProjectId projectId) {
        NetworkActivity[] result;
        foreach (ref e; store)
            if (e.projectId == projectId) result ~= e;
        return result;
    }

    NetworkActivity[] findByWBSElement(WBSElementId wbsElementId) {
        NetworkActivity[] result;
        foreach (ref e; store)
            if (e.wbsElementId == wbsElementId) result ~= e;
        return result;
    }

    void save(NetworkActivity activity) { store ~= activity; }

    void update(NetworkActivity activity) {
        foreach (ref e; store)
            if (e.id == activity.id) { e = activity; return; }
    }

    void remove(NetworkActivityId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
