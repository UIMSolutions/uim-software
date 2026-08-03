module uim.platform.bw.infrastructure.persistence.memory.bw_repository;

import uim.platform.bw.domain.entities.bw_object : BwObject;
import uim.platform.bw.domain.repositories.bw_repository : BwRepository;

@safe:

class MemoryBwRepository : BwRepository {
    private BwObject[] store;

    override BwObject[] listByType(string objectType) {
        BwObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType) {
                result ~= item;
            }
        }
        return result;
    }

    override const(BwObject)* getByTypeAndId(string objectType, string id) {
        foreach (idx, item; store) {
            if (item.objectType == objectType && item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    override bool create(BwObject value) {
        if (getByTypeAndId(value.objectType, value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    override bool update(BwObject value) {
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

    override BwObject[] listByParent(string objectType, string parentId) {
        BwObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType && item.parentId == parentId) {
                result ~= item;
            }
        }
        return result;
    }
}

unittest {
    import uim.platform.bw.domain.entities.bw_object : BwBusinessObjectType;

    auto repo = new MemoryBwRepository();

    BwObject value;
    value.id = "IO-1";
    value.objectType = BwBusinessObjectType.infoObjects;
    value.technicalName = "ZMATNR";

    assert(repo.create(value));
    assert(!repo.create(value));

    auto loaded = repo.getByTypeAndId(BwBusinessObjectType.infoObjects, "IO-1");
    assert(loaded !is null);

    value.businessName = "Material";
    assert(repo.update(value));

    assert(repo.remove(BwBusinessObjectType.infoObjects, "IO-1"));
    assert(!repo.remove(BwBusinessObjectType.infoObjects, "IO-1"));
}
