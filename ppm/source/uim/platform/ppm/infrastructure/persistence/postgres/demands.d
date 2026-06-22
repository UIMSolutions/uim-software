module uim.platform.ppm.infrastructure.persistence.postgres.demands;

import std.array : join;
import uim.platform.ppm.domain.entities.demand;
import uim.platform.ppm.domain.repositories.demand_repository;
import uim.platform.ppm.domain.types;
import uim.platform.ppm.infrastructure.persistence.postgres.common;

@safe:

class PostgresDemandRepository : DemandRepository {
    private PostgresSqlRunner runner;
    private Demand lookupBuffer;

    this(string connectionString) {
        this.runner = PostgresSqlRunner(connectionString);
    }

    Demand[] findAll() {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, portfolio_id, title, description, source, business_value, priority, " ~
            "status, requested_by, created_by, modified_by, created_at, modified_at " ~
            "FROM ppm_demands ORDER BY id"
        );
        Demand[] result;
        foreach (row; rows) {
            result ~= toDemand(row);
        }
        return result;
    }

    Demand* findById(DemandId id) {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, portfolio_id, title, description, source, business_value, priority, " ~
            "status, requested_by, created_by, modified_by, created_at, modified_at " ~
            "FROM ppm_demands WHERE id = " ~ sqlValue(id) ~ " LIMIT 1"
        );
        if (!rows.length) {
            return null;
        }
        lookupBuffer = toDemand(rows[0]);
        return &lookupBuffer;
    }

    void save(Demand value) {
        runner.exec(upsertSql(value));
    }

    void update(Demand value) {
        runner.exec(
            "UPDATE ppm_demands SET " ~
            "tenant_id = " ~ sqlValue(value.tenantId) ~ ", " ~
            "portfolio_id = " ~ sqlValue(value.portfolioId) ~ ", " ~
            "title = " ~ sqlValue(value.title) ~ ", " ~
            "description = " ~ sqlValue(value.description) ~ ", " ~
            "source = " ~ sqlValue(value.source) ~ ", " ~
            "business_value = " ~ sqlValue(value.businessValue) ~ ", " ~
            "priority = " ~ sqlValue(value.priority) ~ ", " ~
            "status = " ~ sqlValue(value.status) ~ ", " ~
            "requested_by = " ~ sqlValue(value.requestedBy) ~ ", " ~
            "created_by = " ~ sqlValue(value.createdBy) ~ ", " ~
            "modified_by = " ~ sqlValue(value.modifiedBy) ~ ", " ~
            "created_at = " ~ sqlValue(value.createdAt) ~ ", " ~
            "modified_at = " ~ sqlValue(value.modifiedAt) ~
            " WHERE id = " ~ sqlValue(value.id)
        );
    }

    void remove(DemandId id) {
        runner.exec("DELETE FROM ppm_demands WHERE id = " ~ sqlValue(id));
    }

    private Demand toDemand(string[] row) {
        Demand value;
        value.id = sqlField(row, 0);
        value.tenantId = sqlField(row, 1);
        value.portfolioId = sqlField(row, 2);
        value.title = sqlField(row, 3);
        value.description = sqlField(row, 4);
        value.source = sqlField(row, 5);
        value.businessValue = sqlField(row, 6);
        value.priority = sqlField(row, 7);
        value.status = sqlField(row, 8);
        value.requestedBy = sqlField(row, 9);
        value.createdBy = sqlField(row, 10);
        value.modifiedBy = sqlField(row, 11);
        value.createdAt = sqlField(row, 12);
        value.modifiedAt = sqlField(row, 13);
        return value;
    }

    private string upsertSql(Demand value) {
        string[] values = [
            sqlValue(value.id),
            sqlValue(value.tenantId),
            sqlValue(value.portfolioId),
            sqlValue(value.title),
            sqlValue(value.description),
            sqlValue(value.source),
            sqlValue(value.businessValue),
            sqlValue(value.priority),
            sqlValue(value.status),
            sqlValue(value.requestedBy),
            sqlValue(value.createdBy),
            sqlValue(value.modifiedBy),
            sqlValue(value.createdAt),
            sqlValue(value.modifiedAt)
        ];

        return
            "INSERT INTO ppm_demands (id, tenant_id, portfolio_id, title, description, source, business_value, " ~
            "priority, status, requested_by, created_by, modified_by, created_at, modified_at) VALUES (" ~
            values.join(", ") ~ ") " ~
            "ON CONFLICT (id) DO UPDATE SET " ~
            "tenant_id = EXCLUDED.tenant_id, " ~
            "portfolio_id = EXCLUDED.portfolio_id, " ~
            "title = EXCLUDED.title, " ~
            "description = EXCLUDED.description, " ~
            "source = EXCLUDED.source, " ~
            "business_value = EXCLUDED.business_value, " ~
            "priority = EXCLUDED.priority, " ~
            "status = EXCLUDED.status, " ~
            "requested_by = EXCLUDED.requested_by, " ~
            "created_by = EXCLUDED.created_by, " ~
            "modified_by = EXCLUDED.modified_by, " ~
            "created_at = EXCLUDED.created_at, " ~
            "modified_at = EXCLUDED.modified_at";
    }
}
