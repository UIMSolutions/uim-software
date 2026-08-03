module uim.platform.npc.domain.repositories.npc_repository;

import uim.platform.npc.domain.entities.npc_object : NpcObject;

@safe:

interface NpcRepository {
    NpcObject[] listByType(string objectType);
    const(NpcObject)* getByTypeAndId(string objectType, string id);
    bool create(NpcObject value);
    bool update(NpcObject value);
    bool remove(string objectType, string id);
    NpcObject[] listByParent(string objectType, string parentId);
}
