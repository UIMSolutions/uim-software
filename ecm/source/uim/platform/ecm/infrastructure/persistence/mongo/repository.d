module uim.platform.ecm.infrastructure.persistence.mongo.repository;

import std.algorithm.searching : canFind;
import vibe.data.json : Json, parseJsonString, serializeToJsonString;
import uim.platform.ecm;
import uim.platform.ecm.infrastructure.persistence.mongo.common;
import uim.platform.ecm.infrastructure.persistence.mongo.migrations;

@safe:

class MongoEcmRepository : EcmRepository {
    private string mongoUrl;
    private string databaseName;
    private MongoShellRunner runner;
    private MemoryEcmRepository fallback;
    private EcmObject lookupBuffer;
    private bool databaseAvailable = false;

    this(string mongoUrl, string databaseName) {
        this.mongoUrl = mongoUrl;
        this.databaseName = databaseName;
        this.runner = MongoShellRunner(mongoUrl, databaseName);
        this.fallback = new MemoryEcmRepository();

        version (unittest) {
            databaseAvailable = false;
        } else {
            try {
                ensureEcmMongoSchema(mongoUrl, databaseName);
                databaseAvailable = true;
            } catch (Exception ex) {
                databaseAvailable = false;
                // Use in-memory fallback when Mongo CLI or server is not available.
            }
        }
    }

    override EcmObject[] listByType(string objectType) {
        if (!databaseAvailable) {
            return fallback.listByType(objectType);
        }

        try {
            auto rows = runner.queryRows(
                "db.ecm_objects.find({objectType:" ~ jsQuote(objectType) ~ "}).sort({id:1}).forEach(function(d){" ~
                "print([d.id||'',d.objectType||'',d.tenantId||'',d.name||'',d.title||'',d.status||'',d.parentId||''," ~
                "d.owner||'',d.description||'',d.externalReference||'',d.createdBy||'',d.modifiedBy||''," ~
                "d.createdAt||'',d.modifiedAt||'',JSON.stringify(d.metadata||{})].join('\\t'));" ~
                "});"
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
                "db.ecm_objects.find({objectType:" ~ jsQuote(objectType) ~ ",id:" ~ jsQuote(id) ~ "}).limit(1).forEach(function(d){" ~
                "print([d.id||'',d.objectType||'',d.tenantId||'',d.name||'',d.title||'',d.status||'',d.parentId||''," ~
                "d.owner||'',d.description||'',d.externalReference||'',d.createdBy||'',d.modifiedBy||''," ~
                "d.createdAt||'',d.modifiedAt||'',JSON.stringify(d.metadata||{})].join('\\t'));" ~
                "});"
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
            auto script =
                "var e = db.ecm_objects.findOne({objectType:" ~ jsQuote(value.objectType) ~ ",id:" ~ jsQuote(value.id) ~ "});" ~
                "if(e){print('EXISTS');}else{" ~
                "db.ecm_objects.insertOne(" ~ toDocument(value) ~ ");print('INSERTED');}";

            auto rows = runner.queryRows(script);
            foreach (row; rows) {
                if (row.length && row[0].canFind("INSERTED")) {
                    return true;
                }
            }
            return false;
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
            auto script =
                "var r = db.ecm_objects.updateOne({objectType:" ~ jsQuote(value.objectType) ~ ",id:" ~ jsQuote(value.id) ~ "}," ~
                "{$set:" ~ toDocument(value) ~ "});print(r.matchedCount);";

            auto rows = runner.queryRows(script);
            if (!rows.length || !rows[0].length) {
                return false;
            }
            return rows[0][0] == "1";
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
            auto script =
                "var r = db.ecm_objects.deleteOne({objectType:" ~ jsQuote(objectType) ~ ",id:" ~ jsQuote(id) ~ "});" ~
                "print(r.deletedCount);";

            auto rows = runner.queryRows(script);
            if (!rows.length || !rows[0].length) {
                return false;
            }
            return rows[0][0] == "1";
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
                "db.ecm_objects.find({objectType:'document-versions',parentId:" ~ jsQuote(documentId) ~ "}).sort({id:1}).forEach(function(d){" ~
                "print([d.id||'',d.objectType||'',d.tenantId||'',d.name||'',d.title||'',d.status||'',d.parentId||''," ~
                "d.owner||'',d.description||'',d.externalReference||'',d.createdBy||'',d.modifiedBy||''," ~
                "d.createdAt||'',d.modifiedAt||'',JSON.stringify(d.metadata||{})].join('\\t'));" ~
                "});"
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

    string getMongoUrl() const {
        return mongoUrl;
    }

    string getDatabaseName() const {
        return databaseName;
    }

    private EcmObject toObject(string[] row) {
        EcmObject value;
        value.id = mongoField(row, 0);
        value.objectType = mongoField(row, 1);
        value.tenantId = mongoField(row, 2);
        value.name = mongoField(row, 3);
        value.title = mongoField(row, 4);
        value.status = mongoField(row, 5);
        value.parentId = mongoField(row, 6);
        value.owner = mongoField(row, 7);
        value.description = mongoField(row, 8);
        value.externalReference = mongoField(row, 9);
        value.createdBy = mongoField(row, 10);
        value.modifiedBy = mongoField(row, 11);
        value.createdAt = mongoField(row, 12);
        value.modifiedAt = mongoField(row, 13);
        value.metadata = jsonToMap(mongoField(row, 14));
        return value;
    }

    private string toDocument(EcmObject value) {
        return "{" ~
            "id:" ~ jsQuote(value.id) ~ "," ~
            "objectType:" ~ jsQuote(value.objectType) ~ "," ~
            "tenantId:" ~ jsQuote(value.tenantId) ~ "," ~
            "name:" ~ jsQuote(value.name) ~ "," ~
            "title:" ~ jsQuote(value.title) ~ "," ~
            "status:" ~ jsQuote(value.status) ~ "," ~
            "parentId:" ~ jsQuote(value.parentId) ~ "," ~
            "owner:" ~ jsQuote(value.owner) ~ "," ~
            "description:" ~ jsQuote(value.description) ~ "," ~
            "externalReference:" ~ jsQuote(value.externalReference) ~ "," ~
            "createdBy:" ~ jsQuote(value.createdBy) ~ "," ~
            "modifiedBy:" ~ jsQuote(value.modifiedBy) ~ "," ~
            "createdAt:" ~ jsQuote(value.createdAt) ~ "," ~
            "modifiedAt:" ~ jsQuote(value.modifiedAt) ~ "," ~
            "metadata:JSON.parse(" ~ jsQuote(serializeMetadata(value.metadata)) ~ ")" ~
            "}";
    }

    private string serializeMetadata(string[string] mapValue) {
        auto j = Json.emptyObject;
        foreach (k, v; mapValue) {
            j[k] = Json(v);
        }
        return serializeToJsonString(j);
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
}

unittest {
    auto repo = new MongoEcmRepository("mongodb://localhost:27017", "ecm");
    assert(repo.getMongoUrl().length > 0);
}
