module uim.platform.spreadsheet.domain.repositories.spreadsheet_repository;

import uim.platform.spreadsheet.domain.entities.spreadsheet;

interface SpreadsheetRepository {
    Spreadsheet[] list();
    Spreadsheet get(string id);
    Spreadsheet create(Spreadsheet spreadsheet);
    Spreadsheet update(Spreadsheet spreadsheet);
    bool remove(string id);
}
