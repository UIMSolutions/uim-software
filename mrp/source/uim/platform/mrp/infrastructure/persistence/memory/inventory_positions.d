module uim.platform.mrp.infrastructure.persistence.memory.inventory_positions;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class MemoryInventoryPositionRepository : InventoryPositionRepository {
    private InventoryPosition[] store;

    InventoryPosition[] findAll() { return store; }

    InventoryPosition* findById(InventoryPositionId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    InventoryPosition[] findByTenant(TenantId tenantId) {
        InventoryPosition[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    InventoryPosition[] findByPlant(PlantId plantId) {
        InventoryPosition[] result;
        foreach (ref e; store)
            if (e.plantId == plantId) result ~= e;
        return result;
    }

    InventoryPosition[] findByMaterial(MaterialId materialId) {
        InventoryPosition[] result;
        foreach (ref e; store)
            if (e.materialId == materialId) result ~= e;
        return result;
    }

    InventoryPosition* findByMaterialAndPlant(MaterialId materialId, PlantId plantId) {
        foreach (ref e; store)
            if (e.materialId == materialId && e.plantId == plantId) return &e;
        return null;
    }

    void save(InventoryPosition inventoryPosition) { store ~= inventoryPosition; }

    void update(InventoryPosition inventoryPosition) {
        foreach (ref e; store)
            if (e.id == inventoryPosition.id) { e = inventoryPosition; return; }
    }

    void remove(InventoryPositionId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
