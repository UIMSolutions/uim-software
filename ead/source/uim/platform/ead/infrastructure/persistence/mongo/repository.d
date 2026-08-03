module uim.platform.ead.infrastructure.persistence.mongo.repository;

import std.algorithm.searching : canFind;
import vibe.data.json : Json, parseJsonString, serializeToJsonString;
import uim.platform.ead.domain.entities.ead_object : EadObject;
import uim.platform.ead.domain.repositories.ead_repository : EadRepository;
import uim.platform.ead.infrastructure.persistence.memory.ead_repository : MemoryEadRepository;
import uim.platform.ead.infrastructure.persistence.mongo.common;
import uim.platform.ead.infrastructure.persistence.mongo.migrations;

@safe:

class MongoEadRepository : EadRepository {
    private MemoryEadRepository fallback;
    private MongoShellRunner runner;
    private string mongoUrl;
    private string databaseName;
    private EadObject lookupBuffer;
    private bool databaseAvailable = false;

    this(string mongoUrl, string databaseName) {
        this.mongoUrl = mongoUrl;
        this.databaseName = databaseName;
        this.runner = MongoShellRunner(mongoUrl, databaseName);
        this.fallback = new MemoryEadRepository();

        version (unittest) {
            databaseAvailable = false;
        } else {
            try {
                ensureEadMongoSchema(mongoUrl, databaseName);
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
            auto rows = runner.queryRows(renderFind(
                "{objectType:" ~ jsQuote(objectType) ~ "}",
                "{id:1}"
            ));
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
            auto rows = runner.queryRows(
                "db.ead_objects.find({objectType:" ~ jsQuote(objectType) ~ ",id:" ~ jsQuote(id) ~ "}).limit(1).forEach(function(d){" ~
                "printRow(d);" ~
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

    override bool create(EadObject value) {
        if (!databaseAvailable) {
            return fallback.create(value);
        }

        try {
            auto script =
                helperFunctions() ~
                "var e = db.ead_objects.findOne({objectType:" ~ jsQuote(value.objectType) ~ ",id:" ~ jsQuote(value.id) ~ "});" ~
                "if(e){print('EXISTS');}else{db.ead_objects.insertOne(" ~ toDocument(value) ~ ");print('INSERTED');}";

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

    override bool update(EadObject value) {
        if (!databaseAvailable) {
            return fallback.update(value);
        }

        try {
            auto script =
                "var r = db.ead_objects.updateOne({objectType:" ~ jsQuote(value.objectType) ~ ",id:" ~ jsQuote(value.id) ~ "},{$set:" ~ toDocument(value) ~ "});" ~
                "print(r.matchedCount);";

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
                "var r = db.ead_objects.deleteOne({objectType:" ~ jsQuote(objectType) ~ ",id:" ~ jsQuote(id) ~ "});" ~
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

    override EadObject[] listByParent(string objectType, string parentId) {
        if (!databaseAvailable) {
            return fallback.listByParent(objectType, parentId);
        }

        try {
            auto rows = runner.queryRows(renderFind(
                "{objectType:" ~ jsQuote(objectType) ~ ",parentId:" ~ jsQuote(parentId) ~ "}",
                "{id:1}"
            ));

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
            auto rows = runner.queryRows(renderFind(
                "{objectType:" ~ jsQuote(objectType) ~ ",sourceId:" ~ jsQuote(sourceId) ~ "}",
                "{id:1}"
            ));

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
            auto rows = runner.queryRows(renderFind(
                "{objectType:" ~ jsQuote(objectType) ~ ",targetId:" ~ jsQuote(targetId) ~ "}",
                "{id:1}"
            ));

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

    string getMongoUrl() const { return mongoUrl; }
    string getDatabaseName() const { return databaseName; }

    private string renderFind(string filter, string sortExpr) {
        return helperFunctions() ~
            "db.ead_objects.find(" ~ filter ~ ").sort(" ~ sortExpr ~ ").forEach(function(d){" ~
            "printRow(d);" ~
            "});";
    }

    private string helperFunctions() {
        return "function printRow(d){print([d.id||'',d.objectType||'',d.tenantId||'',d.technicalName||'',d.businessName||''," ~
            "d.architectureLayer||'',d.lifecycleState||'',d.parentId||'',d.sourceId||'',d.targetId||'',d.owner||''," ~
            "d.description||'',d.externalReference||'',d.createdBy||'',d.modifiedBy||'',d.createdAt||'',d.modifiedAt||''," ~
            "JSON.stringify(d.metadata||{})].join('\\t'));};";
    }

    private EadObject toObject(string[] row) {
        EadObject value;
        value.id = mongoField(row, 0);
        value.objectType = mongoField(row, 1);
        value.tenantId = mongoField(row, 2);
        value.technicalName = mongoField(row, 3);
        value.businessName = mongoField(row, 4);
        value.architectureLayer = mongoField(row, 5);
        value.lifecycleState = mongoField(row, 6);
        value.parentId = mongoField(row, 7);
        value.sourceId = mongoField(row, 8);
        value.targetId = mongoField(row, 9);
        value.owner = mongoField(row, 10);
        value.description = mongoField(row, 11);
        value.externalReference = mongoField(row, 12);
        value.createdBy = mongoField(row, 13);
        value.modifiedBy = mongoField(row, 14);
        value.createdAt = mongoField(row, 15);
        value.modifiedAt = mongoField(row, 16);
        value.metadata = jsonToMap(mongoField(row, 17));
        return value;
    }

    private string toDocument(EadObject value) {
        return "{" ~
            "id:" ~ jsQuote(value.id) ~ "," ~
            "objectType:" ~ jsQuote(value.objectType) ~ "," ~
            "tenantId:" ~ jsQuote(value.tenantId) ~ "," ~
            "technicalName:" ~ jsQuote(value.technicalName) ~ "," ~
            "businessName:" ~ jsQuote(value.businessName) ~ "," ~
            "architectureLayer:" ~ jsQuote(value.architectureLayer) ~ "," ~
            "lifecycleState:" ~ jsQuote(value.lifecycleState) ~ "," ~
            "parentId:" ~ jsQuote(value.parentId) ~ "," ~
            "sourceId:" ~ jsQuote(value.sourceId) ~ "," ~
            "targetId:" ~ jsQuote(value.targetId) ~ "," ~
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
