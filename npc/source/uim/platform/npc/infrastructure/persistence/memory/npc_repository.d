module uim.platform.npc.infrastructure.persistence.memory.npc_repository;

import uim.platform.npc.domain.entities.npc_object : NpcObject;
import uim.platform.npc.domain.repositories.npc_repository : NpcRepository;

@safe:

class MemoryNpcRepository : NpcRepository {
    private NpcObject[] store;

    override NpcObject[] listByType(string objectType) {
        NpcObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType) {
                result ~= item;
            }
        }
        return result;
    }

    override const(NpcObject)* getByTypeAndId(string objectType, string id) {
        foreach (idx, item; store) {
            if (item.objectType == objectType && item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    override bool create(NpcObject value) {
        if (getByTypeAndId(value.objectType, value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    override bool update(NpcObject value) {
        foreach (idx, item; store) {
            if (item.objectType == value.objectType && item.id == value.id) {
                store[idx] = value;
                return true;
            }
        }
        return false;
    }

    override bool remove(string objectType, string id) {
        foreach (idx, item; store) {
            if (item.objectType == objectType && item.id == id) {
                store = store[0 .. idx] ~ store[idx + 1 .. $];
                return true;
            }
        }
        return false;
    }

    override NpcObject[] listByParent(string objectType, string parentId) {
        NpcObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType && item.parentId == parentId) {
                result ~= item;
            }
        }
        return result;
    }
}

unittest {
    import uim.platform.npc.domain.entities.npc_object : NpcBusinessObjectType;

    auto repo = new MemoryNpcRepository();

    NpcObject value;
    value.id = "DP-1";
    value.objectType = NpcBusinessObjectType.demandPlans;
    value.technicalName = "DP_WEEK1";

    assert(repo.create(value));
    assert(!repo.create(value));

    auto loaded = repo.getByTypeAndId(NpcBusinessObjectType.demandPlans, "DP-1");
    assert(loaded !is null);

    value.businessName = "Demand Plan Week 1";
    assert(repo.update(value));

    assert(repo.remove(NpcBusinessObjectType.demandPlans, "DP-1"));
    assert(!repo.remove(NpcBusinessObjectType.demandPlans, "DP-1"));
}
