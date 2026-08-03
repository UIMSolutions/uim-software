module uim.platform.spreadsheet.infrastructure.persistence.memory.memory_spreadsheet_repository;

import std.array : appender;
import std.algorithm : canFind;
import uim.platform.spreadsheet.domain.entities.spreadsheet;
import uim.platform.spreadsheet.domain.repositories.spreadsheet_repository;

class MemorySpreadsheetRepository : SpreadsheetRepository {
    private Spreadsheet[] items;

    override Spreadsheet[] list() {
        return items;
    }

    override Spreadsheet get(string id) {
        foreach (item; items) {
            if (item.id == id) return item;
        }
        return Spreadsheet.init;
    }

    override Spreadsheet create(Spreadsheet spreadsheet) {
        items ~= spreadsheet;
        return spreadsheet;
    }

    override Spreadsheet update(Spreadsheet spreadsheet) {
        foreach (ref item; items) {
            if (item.id == spreadsheet.id) {
                item = spreadsheet;
                return item;
            }
        }
        return spreadsheet;
    }

    override bool remove(string id) {
        size_t index = size_t.max;
        foreach (i, item; items) {
            if (item.id == id) {
                index = i;
                break;
            }
        }

        if (index == size_t.max) return false;
        items = items[0 .. index] ~ items[index + 1 .. $];
        return true;
    }
}
