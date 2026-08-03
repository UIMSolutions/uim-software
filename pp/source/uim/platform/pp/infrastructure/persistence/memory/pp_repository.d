module uim.platform.pp.infrastructure.persistence.memory.pp_repository;

import uim.platform.pp.domain.entities.pp_object : PPObject;
import uim.platform.pp.domain.repositories.pp_repository : PPRepository;

@safe:

class MemoryPPRepository : PPRepository {
    private PPObject[] store;

    override PPObject[] listByType(string objectType) {
        PPObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType) {
                result ~= item;
            }
        }
        return result;
    }

    override const(PPObject)* getByTypeAndId(string objectType, string id) {
        foreach (idx, item; store) {
            if (item.objectType == objectType && item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    override bool create(PPObject value) {
        if (getByTypeAndId(value.objectType, value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    override bool update(PPObject value) {
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

    override PPObject[] listByMaterial(string objectType, string materialId) {
        PPObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType && item.materialId == materialId) {
                result ~= item;
            }
        }
        return result;
    }
}

unittest {
    auto repo = new MemoryPPRepository();
    PPObject v;
    v.id = "M-1";
    v.objectType = "materials";
    v.materialId = "MAT-100";
    v.name = "Material";

    assert(repo.create(v));
    assert(!repo.create(v));
    assert(repo.getByTypeAndId("materials", "M-1") !is null);
    assert(repo.listByMaterial("materials", "MAT-100").length == 1);
    assert(repo.remove("materials", "M-1"));
}
