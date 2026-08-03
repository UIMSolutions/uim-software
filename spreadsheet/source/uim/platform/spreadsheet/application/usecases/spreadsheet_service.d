module uim.platform.spreadsheet.application.usecases.spreadsheet_service;

import std.datetime : Clock, SysTime;
import std.string : format;
import uim.platform.spreadsheet.domain.entities.spreadsheet;
import uim.platform.spreadsheet.domain.repositories.spreadsheet_repository;

class SpreadsheetService {
    private SpreadsheetRepository repository;

    this(SpreadsheetRepository repository) {
        this.repository = repository;
    }

    Spreadsheet[] list() {
        return repository.list();
    }

    Spreadsheet get(string id) {
        return repository.get(id);
    }

    Spreadsheet create(string name, string description, string owner, string[] tags, string[][] rows, string[] columns) {
        auto now = cast(long) Clock.currTime.toUnixTime();
        auto spreadsheet = Spreadsheet("sheet-" ~ format("%s", now), name, description, owner, tags, rows, columns, now, now);
        return repository.create(spreadsheet);
    }

    Spreadsheet update(string id, string name, string description, string owner, string[] tags, string[][] rows, string[] columns) {
        auto now = cast(long) Clock.currTime.toUnixTime();
        auto spreadsheet = Spreadsheet(id, name, description, owner, tags, rows, columns, now, now);
        return repository.update(spreadsheet);
    }

    bool remove(string id) {
        return repository.remove(id);
    }

    string metrics(string id) {
        auto sheet = repository.get(id);
        return sheet.metricsSummary();
    }
}
