module uim.platform.ead.infrastructure.persistence.postgres.common;

import std.array : split;
import std.process : execute;
import std.string : lineSplitter, replace, strip;

@safe:

string sqlQuote(string value) {
    return "'" ~ value.replace("'", "''") ~ "'";
}

string sqlValue(string value) {
    return sqlQuote(value);
}

string sqlField(string[] row, size_t index) {
    return index < row.length ? row[index] : "";
}

struct PostgresSqlRunner {
    string connectionString;

    this(string connectionString) {
        this.connectionString = connectionString;
    }

    void exec(string sql) {
        auto result = executePsql(sql);
        if (result.status != 0) {
            throw new Exception("PostgreSQL command failed: " ~ result.output);
        }
    }

    string[][] queryRows(string sql) {
        auto result = executePsql(sql);
        if (result.status != 0) {
            throw new Exception("PostgreSQL query failed: " ~ result.output);
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

    private auto executePsql(string sql) @trusted {
        return execute([
            "psql",
            "-d", connectionString,
            "-w",
            "-v", "ON_ERROR_STOP=1",
            "-q",
            "-t",
            "-A",
            "-F", "\t",
            "-c", sql
        ]);
    }
}
