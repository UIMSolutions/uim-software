module uim.platform.team.infrastructure.persistence.memory.parts;

import std.algorithm : remove;
import uim.platform.team;

@safe:

class MemoryPartRepository : PartRepository {
    private Part[] store;

    Part[] findAll() { return store; }

    Part[] findByTenant(TenantId tenantId) {
        Part[] result;
        foreach (item; store)
            if (item.tenantId == tenantId)
                result ~= item;
        return result;
    }

    Part* findById(PartId id) @trusted {
        foreach (idx, ref item; store)
            if (item.id == id)
                return &store[idx];
        return null;
    }

    void save(Part part) { store ~= part; }

    void update(Part part) {
        foreach (ref item; store)
            if (item.id == part.id) {
                item = part;
                return;
            }
    }

    void remove(PartId id) {
        store = store.remove!(item => item.id == id);
    }
}
