module uim.platform.pp.domain.repositories.pp_repository;

import uim.platform.pp.domain.entities.pp_object : PPObject;

@safe:

interface PPRepository {
    PPObject[] listByType(string objectType);
    const(PPObject)* getByTypeAndId(string objectType, string id);
    bool create(PPObject value);
    bool update(PPObject value);
    bool remove(string objectType, string id);
    PPObject[] listByMaterial(string objectType, string materialId);
}
