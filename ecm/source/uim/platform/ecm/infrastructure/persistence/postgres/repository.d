module uim.platform.ecm.infrastructure.persistence.postgres.repository;

import std.array : join;
import std.string : replace;
import vibe.data.json : Json, parseJsonString, serializeToJsonString;
import uim.platform.ecm;
import uim.platform.ecm.infrastructure.persistence.postgres.common;
import uim.platform.ecm.infrastructure.persistence.postgres.migrations;

@safe:

class PostgresEcmRepository : EcmRepository {
    private string connectionUrl;
    private PostgresSqlRunner runner;
    private MemoryEcmRepository fallback;
    private EcmObject lookupBuffer;
    private bool databaseAvailable = false;

    this(string connectionUrl) {
        this.connectionUrl = connectionUrl;
        this.runner = PostgresSqlRunner(connectionUrl);
        this.fallback = new MemoryEcmRepository();

        version (unittest) {
            databaseAvailable = false;
        } else {
            try {
                ensureEcmSchema(connectionUrl);
                databaseAvailable = true;
            } catch (Exception ex) {
                databaseAvailable = false;
                // Use in-memory fallback when PostgreSQL is not reachable.
            }
        }
    }

    override EcmObject[] listByType(string objectType) {
        if (!databaseAvailable) {
            return fallback.listByType(objectType);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id, object_type, tenant_id, name, title, status, parent_id, owner, description, " ~
                "external_reference, created_by, modified_by, created_at, modified_at, metadata_json " ~
                "FROM ecm_objects WHERE object_type = " ~ sqlValue(objectType) ~ " ORDER BY id"
            );

            EcmObject[] result;
            foreach (row; rows) {
                result ~= toObject(row);
            }
            return result;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.listByType(objectType);
        }
    }

    override const(EcmObject)* getByTypeAndId(string objectType, string id) {
        if (!databaseAvailable) {
            return fallback.getByTypeAndId(objectType, id);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id, object_type, tenant_id, name, title, status, parent_id, owner, description, " ~
                "external_reference, created_by, modified_by, created_at, modified_at, metadata_json " ~
                "FROM ecm_objects WHERE object_type = " ~ sqlValue(objectType) ~ " AND id = " ~ sqlValue(id) ~ " LIMIT 1"
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

    override bool create(EcmObject value) {
        if (!databaseAvailable) {
            return fallback.create(value);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id FROM ecm_objects WHERE object_type = " ~ sqlValue(value.objectType) ~
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

    override bool update(EcmObject value) {
        if (!databaseAvailable) {
            return fallback.update(value);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id FROM ecm_objects WHERE object_type = " ~ sqlValue(value.objectType) ~
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
                "SELECT id FROM ecm_objects WHERE object_type = " ~ sqlValue(objectType) ~
                " AND id = " ~ sqlValue(id) ~ " LIMIT 1"
            );
            if (!rows.length) {
                return false;
            }

            runner.exec(
                "DELETE FROM ecm_objects WHERE object_type = " ~ sqlValue(objectType) ~
                " AND id = " ~ sqlValue(id)
            );
            return true;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.remove(objectType, id);
        }
    }

    override EcmObject[] listDocumentVersions(string documentId) {
        if (!databaseAvailable) {
            return fallback.listDocumentVersions(documentId);
        }

        try {
            auto rows = runner.queryRows(
                "SELECT id, object_type, tenant_id, name, title, status, parent_id, owner, description, " ~
                "external_reference, created_by, modified_by, created_at, modified_at, metadata_json " ~
                "FROM ecm_objects WHERE object_type = 'document-versions' AND parent_id = " ~ sqlValue(documentId) ~
                " ORDER BY id"
            );

            EcmObject[] result;
            foreach (row; rows) {
                result ~= toObject(row);
            }
            return result;
        } catch (Exception ex) {
            databaseAvailable = false;
            return fallback.listDocumentVersions(documentId);
        }
    }

    string getConnectionUrl() const {
        return connectionUrl;
    }

    private EcmObject toObject(string[] row) {
        EcmObject value;
        value.id = sqlField(row, 0);
        value.objectType = sqlField(row, 1);
        value.tenantId = sqlField(row, 2);
        value.name = sqlField(row, 3);
        value.title = sqlField(row, 4);
        value.status = sqlField(row, 5);
        value.parentId = sqlField(row, 6);
        value.owner = sqlField(row, 7);
        value.description = sqlField(row, 8);
        value.externalReference = sqlField(row, 9);
        value.createdBy = sqlField(row, 10);
        value.modifiedBy = sqlField(row, 11);
        value.createdAt = sqlField(row, 12);
        value.modifiedAt = sqlField(row, 13);
        value.metadata = jsonToMap(sqlField(row, 14));
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

    private string insertSql(EcmObject value) {
        string[] values = [
            sqlValue(value.id),
            sqlValue(value.objectType),
            sqlValue(value.tenantId),
            sqlValue(value.name),
            sqlValue(value.title),
            sqlValue(value.status),
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

        return "INSERT INTO ecm_objects (id, object_type, tenant_id, name, title, status, parent_id, owner, " ~
            "description, external_reference, created_by, modified_by, created_at, modified_at, metadata_json) " ~
            "VALUES (" ~ values.join(", ") ~ ")";
    }

    private string updateSql(EcmObject value) {
        return "UPDATE ecm_objects SET " ~
            "tenant_id = " ~ sqlValue(value.tenantId) ~ ", " ~
            "name = " ~ sqlValue(value.name) ~ ", " ~
            "title = " ~ sqlValue(value.title) ~ ", " ~
            "status = " ~ sqlValue(value.status) ~ ", " ~
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
    auto repo = new PostgresEcmRepository("postgresql://localhost:5432/ecm");
    assert(repo.getConnectionUrl().length > 0);
}
