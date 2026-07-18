module uim.platform.ps.infrastructure.persistence.repositories.projects;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class MemoryProjectRepository : ProjectRepository {
    private Project[] store;

    Project[] findAll() { return store; }

    Project* findById(ProjectId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Project[] findByTenant(TenantId tenantId) {
        Project[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    void save(Project project) { store ~= project; }

    void update(Project project) {
        foreach (ref e; store)
            if (e.id == project.id) { e = project; return; }
    }

    void remove(ProjectId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
