module uim.platform.ppm.infrastructure.persistence.postgres.programs;

import std.array : join;
import uim.platform.ppm.domain.entities.program;
import uim.platform.ppm.domain.repositories.program_repository;
import uim.platform.ppm.domain.types;
import uim.platform.ppm.infrastructure.persistence.postgres.common;

@safe:

class PostgresProgramRepository : ProgramRepository {
    private PostgresSqlRunner runner;
    private Program lookupBuffer;

    this(string connectionString) {
        this.runner = PostgresSqlRunner(connectionString);
    }

    Program[] findAll() {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, portfolio_id, name, objective, status, manager, start_date, end_date, " ~
            "created_by, modified_by, created_at, modified_at FROM ppm_programs ORDER BY id"
        );
        Program[] result;
        foreach (row; rows) {
            result ~= toProgram(row);
        }
        return result;
    }

    Program* findById(ProgramId id) {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, portfolio_id, name, objective, status, manager, start_date, end_date, " ~
            "created_by, modified_by, created_at, modified_at FROM ppm_programs " ~
            "WHERE id = " ~ sqlValue(id) ~ " LIMIT 1"
        );
        if (!rows.length) {
            return null;
        }
        lookupBuffer = toProgram(rows[0]);
        return &lookupBuffer;
    }

    void save(Program value) {
        runner.exec(upsertSql(value));
    }

    void update(Program value) {
        runner.exec(
            "UPDATE ppm_programs SET " ~
            "tenant_id = " ~ sqlValue(value.tenantId) ~ ", " ~
            "portfolio_id = " ~ sqlValue(value.portfolioId) ~ ", " ~
            "name = " ~ sqlValue(value.name) ~ ", " ~
            "objective = " ~ sqlValue(value.objective) ~ ", " ~
            "status = " ~ sqlValue(value.status) ~ ", " ~
            "manager = " ~ sqlValue(value.manager) ~ ", " ~
            "start_date = " ~ sqlValue(value.startDate) ~ ", " ~
            "end_date = " ~ sqlValue(value.endDate) ~ ", " ~
            "created_by = " ~ sqlValue(value.createdBy) ~ ", " ~
            "modified_by = " ~ sqlValue(value.modifiedBy) ~ ", " ~
            "created_at = " ~ sqlValue(value.createdAt) ~ ", " ~
            "modified_at = " ~ sqlValue(value.modifiedAt) ~
            " WHERE id = " ~ sqlValue(value.id)
        );
    }

    void remove(ProgramId id) {
        runner.exec("DELETE FROM ppm_programs WHERE id = " ~ sqlValue(id));
    }

    private Program toProgram(string[] row) {
        Program value;
        value.id = sqlField(row, 0);
        value.tenantId = sqlField(row, 1);
        value.portfolioId = sqlField(row, 2);
        value.name = sqlField(row, 3);
        value.objective = sqlField(row, 4);
        value.status = sqlField(row, 5);
        value.manager = sqlField(row, 6);
        value.startDate = sqlField(row, 7);
        value.endDate = sqlField(row, 8);
        value.createdBy = sqlField(row, 9);
        value.modifiedBy = sqlField(row, 10);
        value.createdAt = sqlField(row, 11);
        value.modifiedAt = sqlField(row, 12);
        return value;
    }

    private string upsertSql(Program value) {
        string[] values = [
            sqlValue(value.id),
            sqlValue(value.tenantId),
            sqlValue(value.portfolioId),
            sqlValue(value.name),
            sqlValue(value.objective),
            sqlValue(value.status),
            sqlValue(value.manager),
            sqlValue(value.startDate),
            sqlValue(value.endDate),
            sqlValue(value.createdBy),
            sqlValue(value.modifiedBy),
            sqlValue(value.createdAt),
            sqlValue(value.modifiedAt)
        ];

        return
            "INSERT INTO ppm_programs (id, tenant_id, portfolio_id, name, objective, status, manager, " ~
            "start_date, end_date, created_by, modified_by, created_at, modified_at) VALUES (" ~
            values.join(", ") ~ ") " ~
            "ON CONFLICT (id) DO UPDATE SET " ~
            "tenant_id = EXCLUDED.tenant_id, " ~
            "portfolio_id = EXCLUDED.portfolio_id, " ~
            "name = EXCLUDED.name, " ~
            "objective = EXCLUDED.objective, " ~
            "status = EXCLUDED.status, " ~
            "manager = EXCLUDED.manager, " ~
            "start_date = EXCLUDED.start_date, " ~
            "end_date = EXCLUDED.end_date, " ~
            "created_by = EXCLUDED.created_by, " ~
            "modified_by = EXCLUDED.modified_by, " ~
            "created_at = EXCLUDED.created_at, " ~
            "modified_at = EXCLUDED.modified_at";
    }
}
