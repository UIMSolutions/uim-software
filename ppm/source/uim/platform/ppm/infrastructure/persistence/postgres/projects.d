module uim.platform.ppm.infrastructure.persistence.postgres.projects;

import std.array : join;
import uim.platform.ppm.domain.entities.project;
import uim.platform.ppm.domain.repositories.project_repository;
import uim.platform.ppm.domain.types;
import uim.platform.ppm.infrastructure.persistence.postgres.common;

@safe:

class PostgresProjectRepository : ProjectRepository {
    private PostgresSqlRunner runner;
    private Project lookupBuffer;

    this(string connectionString) {
        this.runner = PostgresSqlRunner(connectionString);
    }

    Project[] findAll() {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, program_id, name, description, project_type, status, start_date, " ~
            "end_date, project_manager, budget_amount, currency, created_by, modified_by, created_at, " ~
            "modified_at FROM ppm_projects ORDER BY id"
        );
        Project[] result;
        foreach (row; rows) {
            result ~= toProject(row);
        }
        return result;
    }

    Project* findById(ProjectId id) {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, program_id, name, description, project_type, status, start_date, " ~
            "end_date, project_manager, budget_amount, currency, created_by, modified_by, created_at, " ~
            "modified_at FROM ppm_projects WHERE id = " ~ sqlValue(id) ~ " LIMIT 1"
        );
        if (!rows.length) {
            return null;
        }
        lookupBuffer = toProject(rows[0]);
        return &lookupBuffer;
    }

    void save(Project value) {
        runner.exec(upsertSql(value));
    }

    void update(Project value) {
        runner.exec(
            "UPDATE ppm_projects SET " ~
            "tenant_id = " ~ sqlValue(value.tenantId) ~ ", " ~
            "program_id = " ~ sqlValue(value.programId) ~ ", " ~
            "name = " ~ sqlValue(value.name) ~ ", " ~
            "description = " ~ sqlValue(value.description) ~ ", " ~
            "project_type = " ~ sqlValue(value.projectType) ~ ", " ~
            "status = " ~ sqlValue(value.status) ~ ", " ~
            "start_date = " ~ sqlValue(value.startDate) ~ ", " ~
            "end_date = " ~ sqlValue(value.endDate) ~ ", " ~
            "project_manager = " ~ sqlValue(value.projectManager) ~ ", " ~
            "budget_amount = " ~ sqlValue(value.budgetAmount) ~ ", " ~
            "currency = " ~ sqlValue(value.currency) ~ ", " ~
            "created_by = " ~ sqlValue(value.createdBy) ~ ", " ~
            "modified_by = " ~ sqlValue(value.modifiedBy) ~ ", " ~
            "created_at = " ~ sqlValue(value.createdAt) ~ ", " ~
            "modified_at = " ~ sqlValue(value.modifiedAt) ~
            " WHERE id = " ~ sqlValue(value.id)
        );
    }

    void remove(ProjectId id) {
        runner.exec("DELETE FROM ppm_projects WHERE id = " ~ sqlValue(id));
    }

    private Project toProject(string[] row) {
        Project value;
        value.id = sqlField(row, 0);
        value.tenantId = sqlField(row, 1);
        value.programId = sqlField(row, 2);
        value.name = sqlField(row, 3);
        value.description = sqlField(row, 4);
        value.projectType = sqlField(row, 5);
        value.status = sqlField(row, 6);
        value.startDate = sqlField(row, 7);
        value.endDate = sqlField(row, 8);
        value.projectManager = sqlField(row, 9);
        value.budgetAmount = sqlField(row, 10);
        value.currency = sqlField(row, 11);
        value.createdBy = sqlField(row, 12);
        value.modifiedBy = sqlField(row, 13);
        value.createdAt = sqlField(row, 14);
        value.modifiedAt = sqlField(row, 15);
        return value;
    }

    private string upsertSql(Project value) {
        string[] values = [
            sqlValue(value.id),
            sqlValue(value.tenantId),
            sqlValue(value.programId),
            sqlValue(value.name),
            sqlValue(value.description),
            sqlValue(value.projectType),
            sqlValue(value.status),
            sqlValue(value.startDate),
            sqlValue(value.endDate),
            sqlValue(value.projectManager),
            sqlValue(value.budgetAmount),
            sqlValue(value.currency),
            sqlValue(value.createdBy),
            sqlValue(value.modifiedBy),
            sqlValue(value.createdAt),
            sqlValue(value.modifiedAt)
        ];

        return
            "INSERT INTO ppm_projects (id, tenant_id, program_id, name, description, project_type, status, " ~
            "start_date, end_date, project_manager, budget_amount, currency, created_by, modified_by, " ~
            "created_at, modified_at) VALUES (" ~ values.join(", ") ~ ") " ~
            "ON CONFLICT (id) DO UPDATE SET " ~
            "tenant_id = EXCLUDED.tenant_id, " ~
            "program_id = EXCLUDED.program_id, " ~
            "name = EXCLUDED.name, " ~
            "description = EXCLUDED.description, " ~
            "project_type = EXCLUDED.project_type, " ~
            "status = EXCLUDED.status, " ~
            "start_date = EXCLUDED.start_date, " ~
            "end_date = EXCLUDED.end_date, " ~
            "project_manager = EXCLUDED.project_manager, " ~
            "budget_amount = EXCLUDED.budget_amount, " ~
            "currency = EXCLUDED.currency, " ~
            "created_by = EXCLUDED.created_by, " ~
            "modified_by = EXCLUDED.modified_by, " ~
            "created_at = EXCLUDED.created_at, " ~
            "modified_at = EXCLUDED.modified_at";
    }
}
