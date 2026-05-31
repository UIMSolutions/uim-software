module uim.platform.ps.infrastructure.persistence.memory.milestones;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class MemoryMilestoneRepository : MilestoneRepository {
    private Milestone[] store;

    Milestone[] findAll() { return store; }

    Milestone* findById(MilestoneId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Milestone[] findByTenant(TenantId tenantId) {
        Milestone[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    Milestone[] findByProject(ProjectId projectId) {
        Milestone[] result;
        foreach (ref e; store)
            if (e.projectId == projectId) result ~= e;
        return result;
    }

    void save(Milestone milestone) { store ~= milestone; }

    void update(Milestone milestone) {
        foreach (ref e; store)
            if (e.id == milestone.id) { e = milestone; return; }
    }

    void remove(MilestoneId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
