module uim.platform.team.infrastructure.persistence.memory.boms;

import std.algorithm : remove;
import uim.platform.team;

@safe:

class MemoryBomRepository : BomRepository {
    private Bom[] store;

    Bom[] findAll() { return store; }

    Bom[] findByTenant(TenantId tenantId) {
        Bom[] result;
        foreach (item; store)
            if (item.tenantId == tenantId)
                result ~= item;
        return result;
    }

    Bom* findById(BomId id) @trusted {
        foreach (idx, ref item; store)
            if (item.id == id)
                return &store[idx];
        return null;
    }

    Bom[] findByParentPart(PartId parentPartId) {
        Bom[] result;
        foreach (item; store)
            if (item.parentPartId == parentPartId)
                result ~= item;
        return result;
    }

    void save(Bom bom) { store ~= bom; }

    void update(Bom bom) {
        foreach (ref item; store)
            if (item.id == bom.id) {
                item = bom;
                return;
            }
    }

    void remove(BomId id) {
        store = store.remove!(item => item.id == id);
    }
}
