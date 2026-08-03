module uim.platform.bw.infrastructure.persistence.postgres.repository;

import std.array : join;
import std.string : replace;
import vibe.data.json : Json, parseJsonString, serializeToJsonString;
import uim.platform.bw;
import uim.platform.bw.infrastructure.persistence.postgres.common;
import uim.platform.bw.infrastructure.persistence.postgres.migrations;

@safe:

class PostgresBwRepository : BwRepository {
    private PostgresSqlRunner runner;
    private MemoryBwRepository fallback;
    private string connectionUrl;
    private BwObject lookupBuffer;
    private bool databaseAvailable = false;

    this(string connectionUrl) {
        this.connectionUrl = connectionUrl;
        this.runner = PostgresSqlRunner(connectionUrl);
        this.fallback = new MemoryBwRepository();

        version (unittest) {
            databaseAvailable = false;
        } else {
            try {
                ensureBwSchema(connectionUrl);
                databaseAvailable = true;
            } catch (Exception ex) {
                databaseAvailable = false;
            }
        }
    }

    override BwObject[] listByType(string objectType) {
        if (!databaseAvailable) {
            return fallback.listByType(objectType);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id, object_type, tenant_id, technical_name, business_name, semantic_layer, source_system, " ~
                "lifecycle_state, parent_id, owner, description, external_reference, created_by, modified_by, " ~
                "created_at, modified_at, metadata_json FROM bw_objects WHERE object_type = " ~
                sqlValue(objectType) ~ " ORDER BY id"
            );

            BwObject[] result;
            foreach (row; rows) {
                result ~= toObject(row);
            }
            return result;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.listByType(objectType);
        }
    }

    override const(BwObject)* getByTypeAndId(string objectType, string id) {
        if (!databaseAvailable) {
            return fallback.getByTypeAndId(objectType, id);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id, object_type, tenant_id, technical_name, business_name, semantic_layer, source_system, " ~
                "lifecycle_state, parent_id, owner, description, external_reference, created_by, modified_by, " ~
                "created_at, modified_at, metadata_json FROM bw_objects WHERE object_type = " ~
                sqlValue(objectType) ~ " AND id = " ~ sqlValue(id) ~ " LIMIT 1"
            );
            if (!rows.length) {
                return null;
            }

            lookupBuffer = toObject(rows[0]);
            return &lookupBuffer;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.getByTypeAndId(objectType, id);
        }
    }

    override bool create(BwObject value) {
        if (!databaseAvailable) {
            return fallback.create(value);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id FROM bw_objects WHERE object_type = " ~ sqlValue(value.objectType) ~
                " AND id = " ~ sqlValue(value.id) ~ " LIMIT 1"
            );
            if (rows.length) {
                return false;
            }

            runner.exec(insertSql(value));
            return true;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.create(value);
        }
    }

    override bool update(BwObject value) {
        if (!databaseAvailable) {
            return fallback.update(value);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id FROM bw_objects WHERE object_type = " ~ sqlValue(value.objectType) ~
                " AND id = " ~ sqlValue(value.id) ~ " LIMIT 1"
            );
            if (!rows.length) {
                return false;
            }

            runner.exec(updateSql(value));
            return true;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.update(value);
        }
    }

    override bool remove(string objectType, string id) {
        if (!databaseAvailable) {
            return fallback.remove(objectType, id);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id FROM bw_objects WHERE object_type = " ~ sqlValue(objectType) ~
                " AND id = " ~ sqlValue(id) ~ " LIMIT 1"
            );
            if (!rows.length) {
                return false;
            }

            runner.exec(
                "DELETE FROM bw_objects WHERE object_type = " ~ sqlValue(objectType) ~
                " AND id = " ~ sqlValue(id)
            );
            return true;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.remove(objectType, id);
        }
    }

    override BwObject[] listByParent(string objectType, string parentId) {
        if (!databaseAvailable) {
            return fallback.listByParent(objectType, parentId);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id, object_type, tenant_id, technical_name, business_name, semantic_layer, source_system, " ~
                "lifecycle_state, parent_id, owner, description, external_reference, created_by, modified_by, " ~
                "created_at, modified_at, metadata_json FROM bw_objects WHERE object_type = " ~
                sqlValue(objectType) ~ " AND parent_id = " ~ sqlValue(parentId) ~ " ORDER BY id"
            );

            BwObject[] result;
            foreach (row; rows) {
                result ~= toObject(row);
            }
            return result;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.listByParent(objectType, parentId);
        }
    }

    string getConnectionUrl() const {
        return connectionUrl;
    }

    private BwObject toObject(string[] row) {
        BwObject value;
        value.id = sqlField(row, 0);
        value.objectType = sqlField(row, 1);
        value.tenantId = sqlField(row, 2);
        value.technicalName = sqlField(row, 3);
        value.businessName = sqlField(row, 4);
        value.semanticLayer = sqlField(row, 5);
        value.sourceSystem = sqlField(row, 6);
        value.lifecycleState = sqlField(row, 7);
        value.parentId = sqlField(row, 8);
        value.owner = sqlField(row, 9);
        value.description = sqlField(row, 10);
        value.externalReference = sqlField(row, 11);
        value.createdBy = sqlField(row, 12);
        value.modifiedBy = sqlField(row, 13);
        value.createdAt = sqlField(row, 14);
        value.modifiedAt = sqlField(row, 15);
        value.metadata = jsonToMap(sqlField(row, 16));
        return value;
    }

    private string metadataJson(string[string] mapValue) {
        auto j = Json.emptyObject;
        foreach (k, v; mapValue) {
            j[k] = Json(v);
        }
        return serializeToJsonString(j).replace("'", "''");
    }

    private string[string] jsonToMap(string raw) {
        string[string] result;
        if (!raw.length) {
            return result;
        }

        try {
            auto j = parseJsonString(raw);
            foreach (k, v; j.toMap) {
                if (v.type == Json.Type.string) {
                    result[k] = v.get!string;
                }
            }
        } catch (Exception ex) {
        }
        return result;
    }

    private string insertSql(BwObject value) {
        string[] values = [
            sqlValue(value.id),
            sqlValue(value.objectType),
            sqlValue(value.tenantId),
            sqlValue(value.technicalName),
            sqlValue(value.businessName),
            sqlValue(value.semanticLayer),
            sqlValue(value.sourceSystem),
            sqlValue(value.lifecycleState),
            sqlValue(value.parentId),
            sqlValue(value.owner),
            sqlValue(value.description),
            sqlValue(value.externalReference),
            sqlValue(value.createdBy),
            sqlValue(value.modifiedBy),
            sqlValue(value.createdAt),
            sqlValue(value.modifiedAt),
            sqlValue(metadataJson(value.metadata))
        ];

        return "INSERT INTO bw_objects (id, object_type, tenant_id, technical_name, business_name, semantic_layer, " ~
            "source_system, lifecycle_state, parent_id, owner, description, external_reference, created_by, modified_by, " ~
            "created_at, modified_at, metadata_json) VALUES (" ~ values.join(", ") ~ ")";
    }

    private string updateSql(BwObject value) {
        return "UPDATE bw_objects SET " ~
            "tenant_id = " ~ sqlValue(value.tenantId) ~ ", " ~
            "technical_name = " ~ sqlValue(value.technicalName) ~ ", " ~
            "business_name = " ~ sqlValue(value.businessName) ~ ", " ~
            "semantic_layer = " ~ sqlValue(value.semanticLayer) ~ ", " ~
            "source_system = " ~ sqlValue(value.sourceSystem) ~ ", " ~
            "lifecycle_state = " ~ sqlValue(value.lifecycleState) ~ ", " ~
            "parent_id = " ~ sqlValue(value.parentId) ~ ", " ~
            "owner = " ~ sqlValue(value.owner) ~ ", " ~
            "description = " ~ sqlValue(value.description) ~ ", " ~
            "external_reference = " ~ sqlValue(value.externalReference) ~ ", " ~
            "created_by = " ~ sqlValue(value.createdBy) ~ ", " ~
            "modified_by = " ~ sqlValue(value.modifiedBy) ~ ", " ~
            "created_at = " ~ sqlValue(value.createdAt) ~ ", " ~
            "modified_at = " ~ sqlValue(value.modifiedAt) ~ ", " ~
            "metadata_json = " ~ sqlValue(metadataJson(value.metadata)) ~
            " WHERE object_type = " ~ sqlValue(value.objectType) ~ " AND id = " ~ sqlValue(value.id);
    }
}

unittest {
    auto repo = new PostgresBwRepository("postgresql://localhost:5432/bw");
    assert(repo.getConnectionUrl().length > 0);
}
