module uim.platform.ppm.infrastructure.persistence.postgres.resource_requests;

import std.array : join;
import uim.platform.ppm.domain.entities.resource_request;
import uim.platform.ppm.domain.repositories.resource_request_repository;
import uim.platform.ppm.domain.types;
import uim.platform.ppm.infrastructure.persistence.postgres.common;

@safe:

class PostgresResourceRequestRepository : ResourceRequestRepository {
    private PostgresSqlRunner runner;
    private ResourceRequest lookupBuffer;

    this(string connectionString) {
        this.runner = PostgresSqlRunner(connectionString);
    }

    ResourceRequest[] findAll() {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, project_id, role, quantity, allocation_percent, start_date, end_date, " ~
            "status, requested_by, created_by, modified_by, created_at, modified_at " ~
            "FROM ppm_resource_requests ORDER BY id"
        );
        ResourceRequest[] result;
        foreach (row; rows) {
            result ~= toResourceRequest(row);
        }
        return result;
    }

    ResourceRequest* findById(ResourceRequestId id) {
        auto rows = runner.queryRows(
            "SELECT id, tenant_id, project_id, role, quantity, allocation_percent, start_date, end_date, " ~
            "status, requested_by, created_by, modified_by, created_at, modified_at " ~
            "FROM ppm_resource_requests WHERE id = " ~ sqlValue(id) ~ " LIMIT 1"
        );
        if (!rows.length) {
            return null;
        }
        lookupBuffer = toResourceRequest(rows[0]);
        return &lookupBuffer;
    }

    void save(ResourceRequest value) {
        runner.exec(upsertSql(value));
    }

    void update(ResourceRequest value) {
        runner.exec(
            "UPDATE ppm_resource_requests SET " ~
            "tenant_id = " ~ sqlValue(value.tenantId) ~ ", " ~
            "project_id = " ~ sqlValue(value.projectId) ~ ", " ~
            "role = " ~ sqlValue(value.role) ~ ", " ~
            "quantity = " ~ sqlValue(value.quantity) ~ ", " ~
            "allocation_percent = " ~ sqlValue(value.allocationPercent) ~ ", " ~
            "start_date = " ~ sqlValue(value.startDate) ~ ", " ~
            "end_date = " ~ sqlValue(value.endDate) ~ ", " ~
            "status = " ~ sqlValue(value.status) ~ ", " ~
            "requested_by = " ~ sqlValue(value.requestedBy) ~ ", " ~
            "created_by = " ~ sqlValue(value.createdBy) ~ ", " ~
            "modified_by = " ~ sqlValue(value.modifiedBy) ~ ", " ~
            "created_at = " ~ sqlValue(value.createdAt) ~ ", " ~
            "modified_at = " ~ sqlValue(value.modifiedAt) ~
            " WHERE id = " ~ sqlValue(value.id)
        );
    }

    void remove(ResourceRequestId id) {
        runner.exec("DELETE FROM ppm_resource_requests WHERE id = " ~ sqlValue(id));
    }

    private ResourceRequest toResourceRequest(string[] row) {
        ResourceRequest value;
        value.id = sqlField(row, 0);
        value.tenantId = sqlField(row, 1);
        value.projectId = sqlField(row, 2);
        value.role = sqlField(row, 3);
        value.quantity = sqlField(row, 4);
        value.allocationPercent = sqlField(row, 5);
        value.startDate = sqlField(row, 6);
        value.endDate = sqlField(row, 7);
        value.status = sqlField(row, 8);
        value.requestedBy = sqlField(row, 9);
        value.createdBy = sqlField(row, 10);
        value.modifiedBy = sqlField(row, 11);
        value.createdAt = sqlField(row, 12);
        value.modifiedAt = sqlField(row, 13);
        return value;
    }

    private string upsertSql(ResourceRequest value) {
        string[] values = [
            sqlValue(value.id),
            sqlValue(value.tenantId),
            sqlValue(value.projectId),
            sqlValue(value.role),
            sqlValue(value.quantity),
            sqlValue(value.allocationPercent),
            sqlValue(value.startDate),
            sqlValue(value.endDate),
            sqlValue(value.status),
            sqlValue(value.requestedBy),
            sqlValue(value.createdBy),
            sqlValue(value.modifiedBy),
            sqlValue(value.createdAt),
            sqlValue(value.modifiedAt)
        ];

        return
            "INSERT INTO ppm_resource_requests (id, tenant_id, project_id, role, quantity, allocation_percent, " ~
            "start_date, end_date, status, requested_by, created_by, modified_by, created_at, modified_at) " ~
            "VALUES (" ~ values.join(", ") ~ ") " ~
            "ON CONFLICT (id) DO UPDATE SET " ~
            "tenant_id = EXCLUDED.tenant_id, " ~
            "project_id = EXCLUDED.project_id, " ~
            "role = EXCLUDED.role, " ~
            "quantity = EXCLUDED.quantity, " ~
            "allocation_percent = EXCLUDED.allocation_percent, " ~
            "start_date = EXCLUDED.start_date, " ~
            "end_date = EXCLUDED.end_date, " ~
            "status = EXCLUDED.status, " ~
            "requested_by = EXCLUDED.requested_by, " ~
            "created_by = EXCLUDED.created_by, " ~
            "modified_by = EXCLUDED.modified_by, " ~
            "created_at = EXCLUDED.created_at, " ~
            "modified_at = EXCLUDED.modified_at";
    }
}
