module uim.platform.ead.infrastructure.persistence.postgres.repository;

import std.array : join;
import std.string : replace;
import vibe.data.json : Json, parseJsonString, serializeToJsonString;
import uim.platform.ead.domain.entities.ead_object : EadObject;
import uim.platform.ead.domain.repositories.ead_repository : EadRepository;
import uim.platform.ead.infrastructure.persistence.memory.ead_repository : MemoryEadRepository;
import uim.platform.ead.infrastructure.persistence.postgres.common;
import uim.platform.ead.infrastructure.persistence.postgres.migrations;

@safe:

class PostgresEadRepository : EadRepository {
    private PostgresSqlRunner runner;
    private MemoryEadRepository fallback;
    private string connectionUrl;
    private EadObject lookupBuffer;
    private bool databaseAvailable = false;

    this(string connectionUrl) {
        this.connectionUrl = connectionUrl;
        this.runner = PostgresSqlRunner(connectionUrl);
        this.fallback = new MemoryEadRepository();

        version (unittest) {
            databaseAvailable = false;
        } else {
            try {
                ensureEadSchema(connectionUrl);
                databaseAvailable = true;
            } catch (Exception ex) {
                databaseAvailable = false;
            }
        }
    }

    override EadObject[] listByType(string objectType) {
        if (!databaseAvailable) {
            return fallback.listByType(objectType);
        }

        try {
            auto rows = runner.queryRows(baseSelect() ~
                " WHERE object_type = " ~ sqlValue(objectType) ~ " ORDER BY id");
            EadObject[] result;
            foreach (row; rows) {
                result ~= toObject(row);
            }
            return result;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.listByType(objectType);
        }
    }

    override const(EadObject)* getByTypeAndId(string objectType, string id) {
        if (!databaseAvailable) {
            return fallback.getByTypeAndId(objectType, id);
        }

        try {
            auto rows = runner.queryRows(baseSelect() ~
                " WHERE object_type = " ~ sqlValue(objectType) ~
                " AND id = " ~ sqlValue(id) ~ " LIMIT 1");
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

    override bool create(EadObject value) {
        if (!databaseAvailable) {
            return fallback.create(value);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id FROM ead_objects WHERE object_type = " ~ sqlValue(value.objectType) ~
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

    override bool update(EadObject value) {
        if (!databaseAvailable) {
            return fallback.update(value);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id FROM ead_objects WHERE object_type = " ~ sqlValue(value.objectType) ~
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
                "SELECT id FROM ead_objects WHERE object_type = " ~ sqlValue(objectType) ~
                " AND id = " ~ sqlValue(id) ~ " LIMIT 1"
            );
            if (!rows.length) {
                return false;
            }

            runner.exec(
                "DELETE FROM ead_objects WHERE object_type = " ~ sqlValue(objectType) ~
                " AND id = " ~ sqlValue(id)
            );
            return true;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.remove(objectType, id);
        }
    }

    override EadObject[] listByParent(string objectType, string parentId) {
        if (!databaseAvailable) {
            return fallback.listByParent(objectType, parentId);
        }

        try {
            auto rows = runner.queryRows(baseSelect() ~
                " WHERE object_type = " ~ sqlValue(objectType) ~
                " AND parent_id = " ~ sqlValue(parentId) ~ " ORDER BY id");
            EadObject[] result;
            foreach (row; rows) {
                result ~= toObject(row);
            }
            return result;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.listByParent(objectType, parentId);
        }
    }

    override EadObject[] listBySource(string objectType, string sourceId) {
        if (!databaseAvailable) {
            return fallback.listBySource(objectType, sourceId);
        }

        try {
            auto rows = runner.queryRows(baseSelect() ~
                " WHERE object_type = " ~ sqlValue(objectType) ~
                " AND source_id = " ~ sqlValue(sourceId) ~ " ORDER BY id");
            EadObject[] result;
            foreach (row; rows) {
                result ~= toObject(row);
            }
            return result;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.listBySource(objectType, sourceId);
        }
    }

    override EadObject[] listByTarget(string objectType, string targetId) {
        if (!databaseAvailable) {
            return fallback.listByTarget(objectType, targetId);
        }

        try {
            auto rows = runner.queryRows(baseSelect() ~
                " WHERE object_type = " ~ sqlValue(objectType) ~
                " AND target_id = " ~ sqlValue(targetId) ~ " ORDER BY id");
            EadObject[] result;
            foreach (row; rows) {
                result ~= toObject(row);
            }
            return result;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.listByTarget(objectType, targetId);
        }
    }

    string getConnectionUrl() const { return connectionUrl; }

    private string baseSelect() {
        return "SELECT id, object_type, tenant_id, technical_name, business_name, architecture_layer, " ~
            "lifecycle_state, parent_id, source_id, target_id, owner, description, external_reference, " ~
            "created_by, modified_by, created_at, modified_at, metadata_json FROM ead_objects";
    }

    private EadObject toObject(string[] row) {
        EadObject value;
        value.id = sqlField(row, 0);
        value.objectType = sqlField(row, 1);
        value.tenantId = sqlField(row, 2);
        value.technicalName = sqlField(row, 3);
        value.businessName = sqlField(row, 4);
        value.architectureLayer = sqlField(row, 5);
        value.lifecycleState = sqlField(row, 6);
        value.parentId = sqlField(row, 7);
        value.sourceId = sqlField(row, 8);
        value.targetId = sqlField(row, 9);
        value.owner = sqlField(row, 10);
        value.description = sqlField(row, 11);
        value.externalReference = sqlField(row, 12);
        value.createdBy = sqlField(row, 13);
        value.modifiedBy = sqlField(row, 14);
        value.createdAt = sqlField(row, 15);
        value.modifiedAt = sqlField(row, 16);
        value.metadata = jsonToMap(sqlField(row, 17));
        return value;
    }

    private string insertSql(EadObject value) {
        string[] values = [
            sqlValue(value.id),
            sqlValue(value.objectType),
            sqlValue(value.tenantId),
            sqlValue(value.technicalName),
            sqlValue(value.businessName),
            sqlValue(value.architectureLayer),
            sqlValue(value.lifecycleState),
            sqlValue(value.parentId),
            sqlValue(value.sourceId),
            sqlValue(value.targetId),
            sqlValue(value.owner),
            sqlValue(value.description),
            sqlValue(value.externalReference),
            sqlValue(value.createdBy),
            sqlValue(value.modifiedBy),
            sqlValue(value.createdAt),
            sqlValue(value.modifiedAt),
            sqlValue(metadataJson(value.metadata))
        ];

        return "INSERT INTO ead_objects (id, object_type, tenant_id, technical_name, business_name, architecture_layer, " ~
            "lifecycle_state, parent_id, source_id, target_id, owner, description, external_reference, created_by, " ~
            "modified_by, created_at, modified_at, metadata_json) VALUES (" ~ values.join(", ") ~ ")";
    }

    private string updateSql(EadObject value) {
        return "UPDATE ead_objects SET " ~
            "tenant_id = " ~ sqlValue(value.tenantId) ~ ", " ~
            "technical_name = " ~ sqlValue(value.technicalName) ~ ", " ~
            "business_name = " ~ sqlValue(value.businessName) ~ ", " ~
            "architecture_layer = " ~ sqlValue(value.architectureLayer) ~ ", " ~
            "lifecycle_state = " ~ sqlValue(value.lifecycleState) ~ ", " ~
            "parent_id = " ~ sqlValue(value.parentId) ~ ", " ~
            "source_id = " ~ sqlValue(value.sourceId) ~ ", " ~
            "target_id = " ~ sqlValue(value.targetId) ~ ", " ~
            "owner = " ~ sqlValue(value.owner) ~ ", " ~
            "description = " ~ sqlValue(value.description) ~ ", " ~
            "external_reference = " ~ sqlValue(value.externalReference) ~ ", " ~
            "created_by = " ~ sqlValue(value.createdBy) ~ ", " ~
            "modified_by = " ~ sqlValue(value.modifiedBy) ~ ", " ~
            "created_at = " ~ sqlValue(value.createdAt) ~ ", " ~
            "modified_at = " ~ sqlValue(value.modifiedAt) ~ ", " ~
            "metadata_json = " ~ sqlValue(metadataJson(value.metadata)) ~
            " WHERE object_type = " ~ sqlValue(value.objectType) ~
            " AND id = " ~ sqlValue(value.id);
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
            auto map = j.get!(Json[string]);
            foreach (k, v; map) {
                if (v.type == Json.Type.string) {
                    result[k] = v.get!string;
                }
            }
        } catch (Exception ex) {
        }
        return result;
    }
}
