module uim.platform.ead.infrastructure.persistence.memory.ead_repository;

import uim.platform.ead.domain.entities.ead_object : EadObject;
import uim.platform.ead.domain.repositories.ead_repository : EadRepository;

@safe:

class MemoryEadRepository : EadRepository {
    private EadObject[] store;

    override EadObject[] listByType(string objectType) {
        EadObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType) {
                result ~= item;
            }
        }
        return result;
    }

    override const(EadObject)* getByTypeAndId(string objectType, string id) {
        foreach (idx, item; store) {
            if (item.objectType == objectType && item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    override bool create(EadObject value) {
        if (getByTypeAndId(value.objectType, value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    override bool update(EadObject value) {
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

    override EadObject[] listByParent(string objectType, string parentId) {
        EadObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType && item.parentId == parentId) {
                result ~= item;
            }
        }
        return result;
    }

    override EadObject[] listBySource(string objectType, string sourceId) {
        EadObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType && item.sourceId == sourceId) {
                result ~= item;
            }
        }
        return result;
    }

    override EadObject[] listByTarget(string objectType, string targetId) {
        EadObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType && item.targetId == targetId) {
                result ~= item;
            }
        }
        return result;
    }
}

unittest {
    import uim.platform.ead.domain.entities.ead_object : EadBusinessObjectType;

    auto repo = new MemoryEadRepository();

    EadObject value;
    value.id = "A-1";
    value.objectType = EadBusinessObjectType.applicationComponents;
    value.technicalName = "APP_AP";

    assert(repo.create(value));
    assert(!repo.create(value));

    auto loaded = repo.getByTypeAndId(EadBusinessObjectType.applicationComponents, "A-1");
    assert(loaded !is null);

    value.businessName = "Accounts Payable";
    assert(repo.update(value));

    assert(repo.remove(EadBusinessObjectType.applicationComponents, "A-1"));
    assert(!repo.remove(EadBusinessObjectType.applicationComponents, "A-1"));
}
