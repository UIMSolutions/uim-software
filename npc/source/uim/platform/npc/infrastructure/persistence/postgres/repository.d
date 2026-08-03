module uim.platform.npc.infrastructure.persistence.postgres.repository;

import uim.platform.npc;

@safe:

class PostgresNpcRepository : NpcRepository {
    private MemoryNpcRepository fallback;
    private string connectionUrl;

    this(string connectionUrl) {
        this.connectionUrl = connectionUrl;
        this.fallback = new MemoryNpcRepository();
    }

    override NpcObject[] listByType(string objectType) {
        return fallback.listByType(objectType);
    }

    override const(NpcObject)* getByTypeAndId(string objectType, string id) {
        return fallback.getByTypeAndId(objectType, id);
    }

    override bool create(NpcObject value) {
        return fallback.create(value);
    }

    override bool update(NpcObject value) {
        return fallback.update(value);
    }

    override bool remove(string objectType, string id) {
        return fallback.remove(objectType, id);
    }

    override NpcObject[] listByParent(string objectType, string parentId) {
        return fallback.listByParent(objectType, parentId);
    }

    string getConnectionUrl() const {
        return connectionUrl;
    }
}

unittest {
    auto repo = new PostgresNpcRepository("postgresql://localhost:5432/npc");
    assert(repo.getConnectionUrl().length > 0);
}
