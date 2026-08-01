module uim.platform.ecm.infrastructure.persistence.memory.ecm_repository;

import uim.platform.ecm.domain.entities.ecm_object : EcmObject, BusinessObjectType;
import uim.platform.ecm.domain.repositories.ecm_repository : EcmRepository;

@safe:

class MemoryEcmRepository : EcmRepository {
    private EcmObject[] store;

    override EcmObject[] listByType(string objectType) {
        EcmObject[] result;
        foreach (item; store) {
            if (item.objectType == objectType) {
                result ~= item;
            }
        }
        return result;
    }

    override const(EcmObject)* getByTypeAndId(string objectType, string id) {
        foreach (idx, item; store) {
            if (item.objectType == objectType && item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    override bool create(EcmObject value) {
        if (getByTypeAndId(value.objectType, value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    override bool update(EcmObject value) {
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

    override EcmObject[] listDocumentVersions(string documentId) {
        EcmObject[] result;
        foreach (item; store) {
            if (item.objectType == BusinessObjectType.documentVersion && item.parentId == documentId) {
                result ~= item;
            }
        }
        return result;
    }
}

unittest {
    auto repo = new MemoryEcmRepository();

    EcmObject repository;
    repository.id = "R-1";
    repository.objectType = BusinessObjectType.repository;
    repository.name = "Primary";

    assert(repo.create(repository));
    assert(!repo.create(repository));

    auto existing = repo.getByTypeAndId(BusinessObjectType.repository, "R-1");
    assert(existing !is null);

    repository.title = "Repository";
    assert(repo.update(repository));

    assert(repo.remove(BusinessObjectType.repository, "R-1"));
    assert(!repo.remove(BusinessObjectType.repository, "R-1"));
}
