module uim.platform.bw.infrastructure.persistence.mongo.migrations;

import uim.platform.bw.infrastructure.persistence.mongo.common;

@safe:

void ensureBwMongoSchema(string mongoUrl, string databaseName) {
    auto runner = MongoShellRunner(mongoUrl, databaseName);

    runner.exec(
        "db.bw_objects.createIndex({objectType:1,id:1},{unique:true});" ~
        "db.bw_objects.createIndex({parentId:1});"
    );
}
