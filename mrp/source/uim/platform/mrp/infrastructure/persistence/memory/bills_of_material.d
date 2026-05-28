module uim.platform.mrp.infrastructure.persistence.memory.bills_of_material;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class MemoryBillOfMaterialRepository : BillOfMaterialRepository {
    private BillOfMaterial[] store;

    BillOfMaterial[] findAll() { return store; }

    BillOfMaterial* findById(BillOfMaterialId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    BillOfMaterial[] findByTenant(TenantId tenantId) {
        BillOfMaterial[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    BillOfMaterial[] findByPlant(PlantId plantId) {
        BillOfMaterial[] result;
        foreach (ref e; store)
            if (e.plantId == plantId) result ~= e;
        return result;
    }

    BillOfMaterial[] findByParentMaterial(MaterialId materialId) {
        BillOfMaterial[] result;
        foreach (ref e; store)
            if (e.parentMaterialId == materialId) result ~= e;
        return result;
    }

    BillOfMaterial[] findByComponentMaterial(MaterialId materialId) {
        BillOfMaterial[] result;
        foreach (ref e; store)
            if (e.componentMaterialId == materialId) result ~= e;
        return result;
    }

    void save(BillOfMaterial bom) { store ~= bom; }

    void update(BillOfMaterial bom) {
        foreach (ref e; store)
            if (e.id == bom.id) { e = bom; return; }
    }

    void remove(BillOfMaterialId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
