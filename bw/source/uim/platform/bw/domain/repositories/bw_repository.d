module uim.platform.bw.domain.repositories.bw_repository;

import uim.platform.bw.domain.entities.bw_object : BwObject;

@safe:

interface BwRepository {
    BwObject[] listByType(string objectType);
    const(BwObject)* getByTypeAndId(string objectType, string id);
    bool create(BwObject value);
    bool update(BwObject value);
    bool remove(string objectType, string id);
    BwObject[] listByParent(string objectType, string parentId);
}
