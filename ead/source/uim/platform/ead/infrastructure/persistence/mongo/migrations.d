module uim.platform.ead.infrastructure.persistence.mongo.migrations;

import uim.platform.ead.infrastructure.persistence.mongo.common;

@safe:

void ensureEadMongoSchema(string mongoUrl, string databaseName) {
    auto runner = MongoShellRunner(mongoUrl, databaseName);

    runner.exec(
        "db.ead_objects.createIndex({objectType:1,id:1},{unique:true});" ~
        "db.ead_objects.createIndex({parentId:1});" ~
        "db.ead_objects.createIndex({sourceId:1});" ~
        "db.ead_objects.createIndex({targetId:1});"
    );
}
