/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.infrastructure.persistence.memory.material_boms;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class MemoryMaterialBOMRepository : MaterialBOMRepository {
    private MaterialBOM[] store;

    MaterialBOM[] findAll() { return store; }

    MaterialBOM* findById(MaterialBOMId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    MaterialBOM[] findByTenant(TenantId tenantId) {
        MaterialBOM[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    MaterialBOM[] findByEquipment(EquipmentId equipmentId) {
        MaterialBOM[] result;
        foreach (ref e; store)
            if (e.equipmentId == equipmentId) result ~= e;
        return result;
    }

    void save(MaterialBOM bom) { store ~= bom; }

    void update(MaterialBOM bom) {
        foreach (ref e; store)
            if (e.id == bom.id) { e = bom; return; }
    }

    void remove(MaterialBOMId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
