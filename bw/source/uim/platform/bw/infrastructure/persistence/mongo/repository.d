module uim.platform.bw.infrastructure.persistence.mongo.repository;

import std.algorithm.searching : canFind;
import vibe.data.json : Json, parseJsonString, serializeToJsonString;
import uim.platform.bw;
import uim.platform.bw.infrastructure.persistence.mongo.common;
import uim.platform.bw.infrastructure.persistence.mongo.migrations;

@safe:

class MongoBwRepository : BwRepository {
    private MemoryBwRepository fallback;
    private MongoShellRunner runner;
    private string mongoUrl;
    private string databaseName;
    private BwObject lookupBuffer;
    private bool databaseAvailable = false;

    this(string mongoUrl, string databaseName) {
        this.mongoUrl = mongoUrl;
        this.databaseName = databaseName;
        this.runner = MongoShellRunner(mongoUrl, databaseName);
        this.fallback = new MemoryBwRepository();

        version (unittest) {
            databaseAvailable = false;
        } else {
            try {
                ensureBwMongoSchema(mongoUrl, databaseName);
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
                "db.bw_objects.find({objectType:" ~ jsQuote(objectType) ~ "}).sort({id:1}).forEach(function(d){" ~
                "print([d.id||'',d.objectType||'',d.tenantId||'',d.technicalName||'',d.businessName||''," ~
                "d.semanticLayer||'',d.sourceSystem||'',d.lifecycleState||'',d.parentId||'',d.owner||''," ~
                "d.description||'',d.externalReference||'',d.createdBy||'',d.modifiedBy||'',d.createdAt||''," ~
                "d.modifiedAt||'',JSON.stringify(d.metadata||{})].join('\\t'));" ~
                "});"
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
                "db.bw_objects.find({objectType:" ~ jsQuote(objectType) ~ ",id:" ~ jsQuote(id) ~ "}).limit(1).forEach(function(d){" ~
                "print([d.id||'',d.objectType||'',d.tenantId||'',d.technicalName||'',d.businessName||''," ~
                "d.semanticLayer||'',d.sourceSystem||'',d.lifecycleState||'',d.parentId||'',d.owner||''," ~
                "d.description||'',d.externalReference||'',d.createdBy||'',d.modifiedBy||'',d.createdAt||''," ~
                "d.modifiedAt||'',JSON.stringify(d.metadata||{})].join('\\t'));" ~
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

    override bool create(BwObject value) {
        if (!databaseAvailable) {
            return fallback.create(value);
        }

        try {
            auto script =
                "var e = db.bw_objects.findOne({objectType:" ~ jsQuote(value.objectType) ~ ",id:" ~ jsQuote(value.id) ~ "});" ~
                "if(e){print('EXISTS');}else{db.bw_objects.insertOne(" ~ toDocument(value) ~ ");print('INSERTED');}";

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

    override bool update(BwObject value) {
        if (!databaseAvailable) {
            return fallback.update(value);
        }

        try {
            auto script =
                "var r = db.bw_objects.updateOne({objectType:" ~ jsQuote(value.objectType) ~ ",id:" ~ jsQuote(value.id) ~ "},{$set:" ~ toDocument(value) ~ "});" ~
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
                "var r = db.bw_objects.deleteOne({objectType:" ~ jsQuote(objectType) ~ ",id:" ~ jsQuote(id) ~ "});" ~
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

    override BwObject[] listByParent(string objectType, string parentId) {
        if (!databaseAvailable) {
            return fallback.listByParent(objectType, parentId);
        }

        try {
            auto rows = runner.queryRows(
                "db.bw_objects.find({objectType:" ~ jsQuote(objectType) ~ ",parentId:" ~ jsQuote(parentId) ~ "}).sort({id:1}).forEach(function(d){" ~
                "print([d.id||'',d.objectType||'',d.tenantId||'',d.technicalName||'',d.businessName||''," ~
                "d.semanticLayer||'',d.sourceSystem||'',d.lifecycleState||'',d.parentId||'',d.owner||''," ~
                "d.description||'',d.externalReference||'',d.createdBy||'',d.modifiedBy||'',d.createdAt||''," ~
                "d.modifiedAt||'',JSON.stringify(d.metadata||{})].join('\\t'));" ~
                "});"
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

    string getMongoUrl() const {
        return mongoUrl;
    }

    string getDatabaseName() const {
        return databaseName;
    }

    private BwObject toObject(string[] row) {
        BwObject value;
        value.id = mongoField(row, 0);
        value.objectType = mongoField(row, 1);
        value.tenantId = mongoField(row, 2);
        value.technicalName = mongoField(row, 3);
        value.businessName = mongoField(row, 4);
        value.semanticLayer = mongoField(row, 5);
        value.sourceSystem = mongoField(row, 6);
        value.lifecycleState = mongoField(row, 7);
        value.parentId = mongoField(row, 8);
        value.owner = mongoField(row, 9);
        value.description = mongoField(row, 10);
        value.externalReference = mongoField(row, 11);
        value.createdBy = mongoField(row, 12);
        value.modifiedBy = mongoField(row, 13);
        value.createdAt = mongoField(row, 14);
        value.modifiedAt = mongoField(row, 15);
        value.metadata = jsonToMap(mongoField(row, 16));
        return value;
    }

    private string toDocument(BwObject value) {
        return "{" ~
            "id:" ~ jsQuote(value.id) ~ "," ~
            "objectType:" ~ jsQuote(value.objectType) ~ "," ~
            "tenantId:" ~ jsQuote(value.tenantId) ~ "," ~
            "technicalName:" ~ jsQuote(value.technicalName) ~ "," ~
            "businessName:" ~ jsQuote(value.businessName) ~ "," ~
            "semanticLayer:" ~ jsQuote(value.semanticLayer) ~ "," ~
            "sourceSystem:" ~ jsQuote(value.sourceSystem) ~ "," ~
            "lifecycleState:" ~ jsQuote(value.lifecycleState) ~ "," ~
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
    auto repo = new MongoBwRepository("mongodb://localhost:27017", "bw");
    assert(repo.getMongoUrl().length > 0);
    assert(repo.getDatabaseName() == "bw");
}
