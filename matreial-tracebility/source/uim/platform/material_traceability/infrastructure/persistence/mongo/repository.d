module uim.platform.material_traceability.infrastructure.persistence.mongo.repository;

import uim.platform.material_traceability;

@safe:

class MongoMtRepository : MtRepository {
    private MemoryMtRepository fallback;
    private string mongoUrl;
    private string databaseName;

    this(string mongoUrl, string databaseName) {
        this.mongoUrl = mongoUrl;
        this.databaseName = databaseName;
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

    string getMongoUrl() const {
        return mongoUrl;
    }

    string getDatabaseName() const {
        return databaseName;
    }
}

unittest {
    auto repo = new MongoMtRepository("mongodb://localhost:27017", "material_traceability");
    assert(repo.getMongoUrl().length > 0);
    assert(repo.getDatabaseName() == "material_traceability");
}
