module uim.platform.ppm.infrastructure.persistence.postgres.initiatives;

import std.array : join;
import uim.platform.ppm.domain.entities.initiative;
import uim.platform.ppm.domain.repositories.initiative_repository;
import uim.platform.ppm.domain.types;
import uim.platform.ppm.infrastructure.persistence.postgres.common;

@safe:

class PostgresInitiativeRepository : InitiativeRepository {
    private PostgresSqlRunner runner;
    private Initiative lookupBuffer;

    this(string connectionString) {
        this.runner = PostgresSqlRunner(connectionString);
    }

    Initiative[] findAll() {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, portfolio_id, title, description, category, priority, status, sponsor, " ~
            "expected_benefits, created_by, modified_by, created_at, modified_at " ~
            "FROM ppm_initiatives ORDER BY id"
        );
        Initiative[] result;
        foreach (row; rows) {
            result ~= toInitiative(row);
        }
        return result;
    }

    Initiative* findById(InitiativeId id) {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, portfolio_id, title, description, category, priority, status, sponsor, " ~
            "expected_benefits, created_by, modified_by, created_at, modified_at " ~
            "FROM ppm_initiatives WHERE id = " ~ sqlValue(id) ~ " LIMIT 1"
        );
        if (!rows.length) {
            return null;
        }
        lookupBuffer = toInitiative(rows[0]);
        return &lookupBuffer;
    }

    void save(Initiative value) {
        runner.exec(upsertSql(value));
    }

    void update(Initiative value) {
        runner.exec(
            "UPDATE ppm_initiatives SET " ~
            "tenant_id = " ~ sqlValue(value.tenantId) ~ ", " ~
            "portfolio_id = " ~ sqlValue(value.portfolioId) ~ ", " ~
            "title = " ~ sqlValue(value.title) ~ ", " ~
            "description = " ~ sqlValue(value.description) ~ ", " ~
            "category = " ~ sqlValue(value.category) ~ ", " ~
            "priority = " ~ sqlValue(value.priority) ~ ", " ~
            "status = " ~ sqlValue(value.status) ~ ", " ~
            "sponsor = " ~ sqlValue(value.sponsor) ~ ", " ~
            "expected_benefits = " ~ sqlValue(value.expectedBenefits) ~ ", " ~
            "created_by = " ~ sqlValue(value.createdBy) ~ ", " ~
            "modified_by = " ~ sqlValue(value.modifiedBy) ~ ", " ~
            "created_at = " ~ sqlValue(value.createdAt) ~ ", " ~
            "modified_at = " ~ sqlValue(value.modifiedAt) ~
            " WHERE id = " ~ sqlValue(value.id)
        );
    }

    void remove(InitiativeId id) {
        runner.exec("DELETE FROM ppm_initiatives WHERE id = " ~ sqlValue(id));
    }

    private Initiative toInitiative(string[] row) {
        Initiative value;
        value.id = sqlField(row, 0);
        value.tenantId = sqlField(row, 1);
        value.portfolioId = sqlField(row, 2);
        value.title = sqlField(row, 3);
        value.description = sqlField(row, 4);
        value.category = sqlField(row, 5);
        value.priority = sqlField(row, 6);
        value.status = sqlField(row, 7);
        value.sponsor = sqlField(row, 8);
        value.expectedBenefits = sqlField(row, 9);
        value.createdBy = sqlField(row, 10);
        value.modifiedBy = sqlField(row, 11);
        value.createdAt = sqlField(row, 12);
        value.modifiedAt = sqlField(row, 13);
        return value;
    }

    private string upsertSql(Initiative value) {
        string[] values = [
            sqlValue(value.id),
            sqlValue(value.tenantId),
            sqlValue(value.portfolioId),
            sqlValue(value.title),
            sqlValue(value.description),
            sqlValue(value.category),
            sqlValue(value.priority),
            sqlValue(value.status),
            sqlValue(value.sponsor),
            sqlValue(value.expectedBenefits),
            sqlValue(value.createdBy),
            sqlValue(value.modifiedBy),
            sqlValue(value.createdAt),
            sqlValue(value.modifiedAt)
        ];

        return
            "INSERT INTO ppm_initiatives (id, tenant_id, portfolio_id, title, description, category, priority, " ~
            "status, sponsor, expected_benefits, created_by, modified_by, created_at, modified_at) VALUES (" ~
            values.join(", ") ~ ") " ~
            "ON CONFLICT (id) DO UPDATE SET " ~
            "tenant_id = EXCLUDED.tenant_id, " ~
            "portfolio_id = EXCLUDED.portfolio_id, " ~
            "title = EXCLUDED.title, " ~
            "description = EXCLUDED.description, " ~
            "category = EXCLUDED.category, " ~
            "priority = EXCLUDED.priority, " ~
            "status = EXCLUDED.status, " ~
            "sponsor = EXCLUDED.sponsor, " ~
            "expected_benefits = EXCLUDED.expected_benefits, " ~
            "created_by = EXCLUDED.created_by, " ~
            "modified_by = EXCLUDED.modified_by, " ~
            "created_at = EXCLUDED.created_at, " ~
            "modified_at = EXCLUDED.modified_at";
    }
}
