module uim.platform.mrp.infrastructure.persistence.memory.mrp_runs;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class MemoryMrpRunRepository : MrpRunRepository {
    private MrpRun[] store;

    MrpRun[] findAll() { return store; }

    MrpRun* findById(MrpRunId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    MrpRun[] findByTenant(TenantId tenantId) {
        MrpRun[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    MrpRun[] findByPlant(PlantId plantId) {
        MrpRun[] result;
        foreach (ref e; store)
            if (e.plantId == plantId) result ~= e;
        return result;
    }

    MrpRun[] findByStatus(RunStatus status) {
        MrpRun[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    void save(MrpRun mrpRun) { store ~= mrpRun; }

    void update(MrpRun mrpRun) {
        foreach (ref e; store)
            if (e.id == mrpRun.id) { e = mrpRun; return; }
    }

    void remove(MrpRunId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
