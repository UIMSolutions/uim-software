module uim.platform.ecm.domain.repositories.ecm_repository;

import uim.platform.ecm.domain.entities.ecm_object : EcmObject;

@safe:

interface EcmRepository {
    EcmObject[] listByType(string objectType);
    const(EcmObject)* getByTypeAndId(string objectType, string id);
    bool create(EcmObject value);
    bool update(EcmObject value);
    bool remove(string objectType, string id);
    EcmObject[] listDocumentVersions(string documentId);
}
