module uim.platform.spreadsheet.domain.entities.spreadsheet;

import std.string : format;

struct Spreadsheet {
    string id;
    string name;
    string description;
    string owner;
    string[] tags;
    string[][] rows;
    string[] columns;
    long createdAt;
    long updatedAt;

    this(string id, string name, string description, string owner, string[] tags, string[][] rows, string[] columns, long createdAt, long updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.owner = owner;
        this.tags = tags;
        this.rows = rows;
        this.columns = columns;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    string metricsSummary() const {
        return format("%s columns, %s rows", columns.length, rows.length);
    }
}
