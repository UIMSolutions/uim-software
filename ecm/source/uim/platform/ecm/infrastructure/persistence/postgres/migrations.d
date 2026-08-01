module uim.platform.ecm.infrastructure.persistence.postgres.migrations;

import uim.platform.ecm.infrastructure.persistence.postgres.common;

@safe:

enum string ECM_SCHEMA_SQL = q"EOSQL
CREATE TABLE IF NOT EXISTS ecm_objects (
    id TEXT NOT NULL,
    object_type TEXT NOT NULL,
    tenant_id TEXT,
    name TEXT,
    title TEXT,
    status TEXT,
    parent_id TEXT,
    owner TEXT,
    description TEXT,
    external_reference TEXT,
    created_by TEXT,
    modified_by TEXT,
    created_at TEXT,
    modified_at TEXT,
    metadata_json TEXT,
    PRIMARY KEY (object_type, id)
);

CREATE INDEX IF NOT EXISTS idx_ecm_objects_type ON ecm_objects(object_type);
CREATE INDEX IF NOT EXISTS idx_ecm_objects_parent ON ecm_objects(parent_id);
EOSQL";

void ensureEcmSchema(string connectionString) {
    auto runner = PostgresSqlRunner(connectionString);
    runner.exec(ECM_SCHEMA_SQL);
}
