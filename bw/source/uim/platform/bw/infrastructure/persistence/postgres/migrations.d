module uim.platform.bw.infrastructure.persistence.postgres.migrations;

import uim.platform.bw.infrastructure.persistence.postgres.common;

@safe:

enum string BW_SCHEMA_SQL = q"EOSQL
CREATE TABLE IF NOT EXISTS bw_objects (
    id TEXT NOT NULL,
    object_type TEXT NOT NULL,
    tenant_id TEXT,
    technical_name TEXT,
    business_name TEXT,
    semantic_layer TEXT,
    source_system TEXT,
    lifecycle_state TEXT,
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

CREATE INDEX IF NOT EXISTS idx_bw_objects_type ON bw_objects(object_type);
CREATE INDEX IF NOT EXISTS idx_bw_objects_parent ON bw_objects(parent_id);
EOSQL";

void ensureBwSchema(string connectionString) {
    auto runner = PostgresSqlRunner(connectionString);
    runner.exec(BW_SCHEMA_SQL);
}
