module uim.platform.rpm.infrastructure.persistence.memory.rpm_repository;

import uim.platform.rpm.domain.entities.rpm_object : RpmObject;
import uim.platform.rpm.domain.repositories.rpm_repository : RpmRepository;

@safe:

class MemoryRpmRepository : RpmRepository {
    private RpmObject[] store;

    override RpmObject[] listByType(string objectType) {
        RpmObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType) {
                result ~= item;
            }
        }
        return result;
    }

    override RpmObject[] listByParent(string objectType, string parentId) {
        RpmObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType && item.parentId == parentId) {
                result ~= item;
            }
        }
        return result;
    }

    override const(RpmObject)* getByTypeAndId(string objectType, string id) {
        foreach (idx, item; store) {
            if (item.objectType == objectType && item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    override bool create(RpmObject value) {
        if (getByTypeAndId(value.objectType, value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    override bool update(RpmObject value) {
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
}

unittest {
    import uim.platform.rpm.domain.entities.rpm_object : RpmBusinessObjectType;

    auto repo = new MemoryRpmRepository();

    RpmObject value;
    value.id = "MAT-1";
    value.objectType = RpmBusinessObjectType.packagingMaterials;
    value.technicalName = "PALLET";

    assert(repo.create(value));
    assert(!repo.create(value));
    assert(repo.getByTypeAndId(RpmBusinessObjectType.packagingMaterials, "MAT-1") !is null);

    value.businessName = "Euro pallet";
    assert(repo.update(value));

    assert(repo.remove(RpmBusinessObjectType.packagingMaterials, "MAT-1"));
}
