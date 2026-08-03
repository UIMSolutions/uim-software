module uim.platform.material_traceability.domain.repositories.mt_repository;

import uim.platform.material_traceability.domain.entities.mt_object : MtObject;

@safe:

interface MtRepository {
    MtObject[] listByType(string objectType);
    const(MtObject)* getByTypeAndId(string objectType, string id);
    bool create(MtObject value);
    bool update(MtObject value);
    bool remove(string objectType, string id);
    MtObject[] listByParent(string objectType, string parentId);
}
