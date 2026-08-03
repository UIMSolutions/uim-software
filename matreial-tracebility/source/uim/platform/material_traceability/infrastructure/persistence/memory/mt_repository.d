module uim.platform.material_traceability.infrastructure.persistence.memory.mt_repository;

import uim.platform.material_traceability.domain.entities.mt_object : MtObject;
import uim.platform.material_traceability.domain.repositories.mt_repository : MtRepository;

@safe:

class MemoryMtRepository : MtRepository {
    private MtObject[] store;

    override MtObject[] listByType(string objectType) {
        MtObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType) {
                result ~= item;
            }
        }
        return result;
    }

    override const(MtObject)* getByTypeAndId(string objectType, string id) {
        foreach (idx, item; store) {
            if (item.objectType == objectType && item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    override bool create(MtObject value) {
        if (getByTypeAndId(value.objectType, value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    override bool update(MtObject value) {
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

    override MtObject[] listByParent(string objectType, string parentId) {
        MtObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType && item.parentId == parentId) {
                result ~= item;
            }
        }
        return result;
    }
}

unittest {
    import uim.platform.material_traceability.domain.entities.mt_object : MtBusinessObjectType;

    auto repo = new MemoryMtRepository();

    MtObject value;
    value.id = "MAT-1";
    value.objectType = MtBusinessObjectType.materials;
    value.technicalName = "MAT_1";

    assert(repo.create(value));
    assert(!repo.create(value));

    auto loaded = repo.getByTypeAndId(MtBusinessObjectType.materials, "MAT-1");
    assert(loaded !is null);

    value.businessName = "Sample";
    assert(repo.update(value));

    assert(repo.remove(MtBusinessObjectType.materials, "MAT-1"));
    assert(!repo.remove(MtBusinessObjectType.materials, "MAT-1"));
}
