module uim.platform.rpm.domain.repositories.rpm_repository;

import uim.platform.rpm.domain.entities.rpm_object : RpmObject;

@safe:

interface RpmRepository {
    RpmObject[] listByType(string objectType);
    RpmObject[] listByParent(string objectType, string parentId);
    const(RpmObject)* getByTypeAndId(string objectType, string id);
    bool create(RpmObject value);
    bool update(RpmObject value);
    bool remove(string objectType, string id);
}
