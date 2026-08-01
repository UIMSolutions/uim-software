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
