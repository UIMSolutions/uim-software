module uim.platform.ead.domain.repositories.ead_repository;

import uim.platform.ead.domain.entities.ead_object : EadObject;

@safe:

interface EadRepository {
    EadObject[] listByType(string objectType);
    const(EadObject)* getByTypeAndId(string objectType, string id);
    bool create(EadObject value);
    bool update(EadObject value);
    bool remove(string objectType, string id);
    EadObject[] listByParent(string objectType, string parentId);
    EadObject[] listBySource(string objectType, string sourceId);
    EadObject[] listByTarget(string objectType, string targetId);
}
