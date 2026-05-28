module uim.platform.mrp.infrastructure.persistence.memory.materials;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class MemoryMaterialRepository : MaterialRepository {
    private Material[] store;

    Material[] findAll() { return store; }

    Material* findById(MaterialId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    Material[] findByTenant(TenantId tenantId) {
        Material[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    Material[] findByPlant(PlantId plantId) {
        Material[] result;
        foreach (ref e; store)
            if (e.plantId == plantId) result ~= e;
        return result;
    }

    void save(Material material) { store ~= material; }

    void update(Material material) {
        foreach (ref e; store)
            if (e.id == material.id) { e = material; return; }
    }

    void remove(MaterialId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
