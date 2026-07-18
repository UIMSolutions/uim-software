module uim.platform.ps.infrastructure.persistence.repositories.project_costs;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class MemoryProjectCostRepository : ProjectCostRepository {
    private ProjectCost[] store;

    ProjectCost[] findAll() { return store; }

    ProjectCost* findById(ProjectCostId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    ProjectCost[] findByTenant(TenantId tenantId) {
        ProjectCost[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    ProjectCost[] findByProject(ProjectId projectId) {
        ProjectCost[] result;
        foreach (ref e; store)
            if (e.projectId == projectId) result ~= e;
        return result;
    }

    ProjectCost[] findByWBSElement(WBSElementId wbsElementId) {
        ProjectCost[] result;
        foreach (ref e; store)
            if (e.wbsElementId == wbsElementId) result ~= e;
        return result;
    }

    void save(ProjectCost cost) { store ~= cost; }

    void update(ProjectCost cost) {
        foreach (ref e; store)
            if (e.id == cost.id) { e = cost; return; }
    }

    void remove(ProjectCostId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
