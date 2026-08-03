module uim.platform.spreadsheet;

public import uim.platform.spreadsheet.domain;
public import uim.platform.spreadsheet.application;
public import uim.platform.spreadsheet.infrastructure;
public import uim.platform.spreadsheet.presentation;

import std.string : toLower;

struct SpreadsheetConfig {
    string host = "0.0.0.0";
    ushort port = 8080;
    string repositoryType = "memory";
}

SpreadsheetConfig loadConfig() {
    return SpreadsheetConfig();
}

struct SpreadsheetContainer {
    HealthController healthController;
    SpreadsheetApiController apiController;
}

SpreadsheetContainer buildContainer(SpreadsheetConfig config) {
    auto repo = new MemorySpreadsheetRepository();
    auto service = new SpreadsheetService(repo);
    auto healthController = new HealthController();
    auto apiController = new SpreadsheetApiController(service);
    return SpreadsheetContainer(healthController, apiController);
}
