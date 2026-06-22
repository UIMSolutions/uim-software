module uim.platform.ppm.infrastructure.persistence.postgres.portfolios;

import std.array : join;
import uim.platform.ppm.domain.entities.portfolio;
import uim.platform.ppm.domain.repositories.portfolio_repository;
import uim.platform.ppm.domain.types;
import uim.platform.ppm.infrastructure.persistence.postgres.common;

@safe:

class PostgresPortfolioRepository : PortfolioRepository {
    private PostgresSqlRunner runner;
    private Portfolio lookupBuffer;

    this(string connectionString) {
        this.runner = PostgresSqlRunner(connectionString);
    }

    Portfolio[] findAll() {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, name, description, strategic_theme, status, planning_horizon, owner, " ~
            "budget_amount, currency, created_by, modified_by, created_at, modified_at " ~
            "FROM ppm_portfolios ORDER BY id"
        );
        Portfolio[] result;
        foreach (row; rows) {
            result ~= toPortfolio(row);
        }
        return result;
    }

    Portfolio* findById(PortfolioId id) {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, name, description, strategic_theme, status, planning_horizon, owner, " ~
            "budget_amount, currency, created_by, modified_by, created_at, modified_at " ~
            "FROM ppm_portfolios WHERE id = " ~ sqlValue(id) ~ " LIMIT 1"
        );
        if (!rows.length) {
            return null;
        }
        lookupBuffer = toPortfolio(rows[0]);
        return &lookupBuffer;
    }

    void save(Portfolio value) {
        runner.exec(upsertSql(value));
    }

    void update(Portfolio value) {
        runner.exec(
            "UPDATE ppm_portfolios SET " ~
            "tenant_id = " ~ sqlValue(value.tenantId) ~ ", " ~
            "name = " ~ sqlValue(value.name) ~ ", " ~
            "description = " ~ sqlValue(value.description) ~ ", " ~
            "strategic_theme = " ~ sqlValue(value.strategicTheme) ~ ", " ~
            "status = " ~ sqlValue(value.status) ~ ", " ~
            "planning_horizon = " ~ sqlValue(value.planningHorizon) ~ ", " ~
            "owner = " ~ sqlValue(value.owner) ~ ", " ~
            "budget_amount = " ~ sqlValue(value.budgetAmount) ~ ", " ~
            "currency = " ~ sqlValue(value.currency) ~ ", " ~
            "created_by = " ~ sqlValue(value.createdBy) ~ ", " ~
            "modified_by = " ~ sqlValue(value.modifiedBy) ~ ", " ~
            "created_at = " ~ sqlValue(value.createdAt) ~ ", " ~
            "modified_at = " ~ sqlValue(value.modifiedAt) ~
            " WHERE id = " ~ sqlValue(value.id)
        );
    }

    void remove(PortfolioId id) {
        runner.exec("DELETE FROM ppm_portfolios WHERE id = " ~ sqlValue(id));
    }

    private Portfolio toPortfolio(string[] row) {
        Portfolio value;
        value.id = sqlField(row, 0);
        value.tenantId = sqlField(row, 1);
        value.name = sqlField(row, 2);
        value.description = sqlField(row, 3);
        value.strategicTheme = sqlField(row, 4);
        value.status = sqlField(row, 5);
        value.planningHorizon = sqlField(row, 6);
        value.owner = sqlField(row, 7);
        value.budgetAmount = sqlField(row, 8);
        value.currency = sqlField(row, 9);
        value.createdBy = sqlField(row, 10);
        value.modifiedBy = sqlField(row, 11);
        value.createdAt = sqlField(row, 12);
        value.modifiedAt = sqlField(row, 13);
        return value;
    }

    private string upsertSql(Portfolio value) {
        string[] values = [
            sqlValue(value.id),
            sqlValue(value.tenantId),
            sqlValue(value.name),
            sqlValue(value.description),
            sqlValue(value.strategicTheme),
            sqlValue(value.status),
            sqlValue(value.planningHorizon),
            sqlValue(value.owner),
            sqlValue(value.budgetAmount),
            sqlValue(value.currency),
            sqlValue(value.createdBy),
            sqlValue(value.modifiedBy),
            sqlValue(value.createdAt),
            sqlValue(value.modifiedAt)
        ];

        return
            "INSERT INTO ppm_portfolios (id, tenant_id, name, description, strategic_theme, status, " ~
            "planning_horizon, owner, budget_amount, currency, created_by, modified_by, created_at, modified_at) " ~
            "VALUES (" ~ values.join(", ") ~ ") " ~
            "ON CONFLICT (id) DO UPDATE SET " ~
            "tenant_id = EXCLUDED.tenant_id, " ~
            "name = EXCLUDED.name, " ~
            "description = EXCLUDED.description, " ~
            "strategic_theme = EXCLUDED.strategic_theme, " ~
            "status = EXCLUDED.status, " ~
            "planning_horizon = EXCLUDED.planning_horizon, " ~
            "owner = EXCLUDED.owner, " ~
            "budget_amount = EXCLUDED.budget_amount, " ~
            "currency = EXCLUDED.currency, " ~
            "created_by = EXCLUDED.created_by, " ~
            "modified_by = EXCLUDED.modified_by, " ~
            "created_at = EXCLUDED.created_at, " ~
            "modified_at = EXCLUDED.modified_at";
    }
}
