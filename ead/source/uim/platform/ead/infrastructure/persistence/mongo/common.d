module uim.platform.ead.infrastructure.persistence.mongo.common;

import std.array : split;
import std.process : execute;
import std.string : lineSplitter, replace, strip;

@safe:

string jsQuote(string value) {
    return "'" ~ value.replace("\\", "\\\\").replace("'", "\\'") ~ "'";
}

string mongoField(string[] row, size_t index) {
    return index < row.length ? row[index] : "";
}

struct MongoShellRunner {
    string mongoUrl;
    string databaseName;

    this(string mongoUrl, string databaseName) {
        this.mongoUrl = mongoUrl;
        this.databaseName = databaseName;
    }

    void exec(string jsScript) {
        auto result = executeMongo(jsScript);
        if (result.status != 0) {
            throw new Exception("Mongo command failed: " ~ result.output);
        }
    }

    string[][] queryRows(string jsScript) {
        auto result = executeMongo(jsScript);
        if (result.status != 0) {
            throw new Exception("Mongo query failed: " ~ result.output);
        }

        string[][] rows;
        foreach (line; result.output.lineSplitter()) {
            auto trimmed = line.strip();
            if (!trimmed.length) {
                continue;
            }
            rows ~= trimmed.split("\t");
        }
        return rows;
    }

    private auto executeMongo(string jsScript) @trusted {
        return execute([
            "mongosh",
            mongoUrl ~ "/" ~ databaseName,
            "--quiet",
            "--eval", jsScript
        ]);
    }
}
