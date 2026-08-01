module uim.platform.ecm.infrastructure.persistence.mongo.migrations;

import uim.platform.ecm.infrastructure.persistence.mongo.common;

@safe:

void ensureEcmMongoSchema(string mongoUrl, string databaseName) {
    auto runner = MongoShellRunner(mongoUrl, databaseName);

    runner.exec(
        "db.ecm_objects.createIndex({objectType:1,id:1},{unique:true});" ~
        "db.ecm_objects.createIndex({parentId:1});"
    );
}
