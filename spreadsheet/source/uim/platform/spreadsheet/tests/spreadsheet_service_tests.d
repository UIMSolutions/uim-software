module uim.platform.spreadsheet.tests.spreadsheet_service_tests;

import std.stdio;
import uim.platform.spreadsheet.application.usecases.spreadsheet_service;
import uim.platform.spreadsheet.infrastructure.persistence.memory.memory_spreadsheet_repository;
import uim.platform.spreadsheet.domain.entities.spreadsheet;

unittest {
    auto repo = new MemorySpreadsheetRepository();
    auto service = new SpreadsheetService(repo);

    auto created = service.create("Sales Overview", "Executive dashboard", "analyst", ["finance"], [["North", "100"],["South", "80"]], ["Region", "Revenue"]);
    assert(created.id.length > 0);
    assert(service.list().length == 1);

    auto fetched = service.get(created.id);
    assert(fetched.name == "Sales Overview");

    auto metrics = service.metrics(created.id);
    assert(metrics == "2 columns, 2 rows");

    auto updated = service.update(created.id, "Sales Overview", "Updated", "analyst", ["finance", "ops"], [["North", "100"],["South", "80"]], ["Region", "Revenue"]);
    assert(updated.description == "Updated");

    assert(service.remove(created.id));
    assert(service.list().length == 0);
}
