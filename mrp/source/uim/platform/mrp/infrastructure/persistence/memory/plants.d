module uim.platform.mrp.infrastructure.persistence.memory.plants;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class MemoryPlantRepository : PlantRepository {
    private Plant[] store;

    Plant[] findAll() { return store; }

    Plant* findById(PlantId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Plant[] findByTenant(TenantId tenantId) {
        Plant[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    void save(Plant plant) { store ~= plant; }

    void update(Plant plant) {
        foreach (ref e; store)
            if (e.id == plant.id) { e = plant; return; }
    }

    void remove(PlantId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
