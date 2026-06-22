module uim.platform.ppm.domain.entities.resource_request;

import uim.platform.ppm.domain.types;

@safe:

struct ResourceRequest {
    ResourceRequestId id;
    TenantId tenantId;
    ProjectId projectId;
    string role;
    string quantity;
    string allocationPercent;
    string startDate;
    string endDate;
    string status = "requested";
    string requestedBy;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
