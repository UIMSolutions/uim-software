module uim.platform.npc.infrastructure.persistence.mongo.repository;

import uim.platform.npc;

@safe:

class MongoNpcRepository : NpcRepository {
    private MemoryNpcRepository fallback;
    private string mongoUrl;
    private string databaseName;

    this(string mongoUrl, string databaseName) {
        this.mongoUrl = mongoUrl;
        this.databaseName = databaseName;
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

    string getMongoUrl() const {
        return mongoUrl;
    }

    string getDatabaseName() const {
        return databaseName;
    }
}

unittest {
    auto repo = new MongoNpcRepository("mongodb://localhost:27017", "npc");
    assert(repo.getMongoUrl().length > 0);
    assert(repo.getDatabaseName() == "npc");
}
