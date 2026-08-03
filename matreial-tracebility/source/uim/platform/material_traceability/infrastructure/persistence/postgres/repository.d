module uim.platform.material_traceability.infrastructure.persistence.postgres.repository;

import uim.platform.material_traceability;

@safe:

class PostgresMtRepository : MtRepository {
    private MemoryMtRepository fallback;
    private string connectionUrl;

    this(string connectionUrl) {
        this.connectionUrl = connectionUrl;
        this.fallback = new MemoryMtRepository();
    }

    override MtObject[] listByType(string objectType) {
        return fallback.listByType(objectType);
    }

    override const(MtObject)* getByTypeAndId(string objectType, string id) {
        return fallback.getByTypeAndId(objectType, id);
    }

    override bool create(MtObject value) {
        return fallback.create(value);
    }

    override bool update(MtObject value) {
        return fallback.update(value);
    }

    override bool remove(string objectType, string id) {
        return fallback.remove(objectType, id);
    }

    override MtObject[] listByParent(string objectType, string parentId) {
        return fallback.listByParent(objectType, parentId);
    }

    string getConnectionUrl() const {
        return connectionUrl;
    }
}

unittest {
    auto repo = new PostgresMtRepository("postgresql://localhost:5432/material_traceability");
    assert(repo.getConnectionUrl().length > 0);
}
