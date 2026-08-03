module uim.platform.ead.infrastructure.persistence.postgres.migrations;

import uim.platform.ead.infrastructure.persistence.postgres.common;

@safe:

enum string EAD_SCHEMA_SQL = q"EOSQL
CREATE TABLE IF NOT EXISTS ead_objects (
    id TEXT NOT NULL,
    object_type TEXT NOT NULL,
    tenant_id TEXT,
    technical_name TEXT,
    business_name TEXT,
    architecture_layer TEXT,
    lifecycle_state TEXT,
    parent_id TEXT,
    source_id TEXT,
    target_id TEXT,
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

CREATE INDEX IF NOT EXISTS idx_ead_objects_type ON ead_objects(object_type);
CREATE INDEX IF NOT EXISTS idx_ead_objects_parent ON ead_objects(parent_id);
CREATE INDEX IF NOT EXISTS idx_ead_objects_source ON ead_objects(source_id);
CREATE INDEX IF NOT EXISTS idx_ead_objects_target ON ead_objects(target_id);
EOSQL";

void ensureEadSchema(string connectionString) {
    auto runner = PostgresSqlRunner(connectionString);
    runner.exec(EAD_SCHEMA_SQL);
}
