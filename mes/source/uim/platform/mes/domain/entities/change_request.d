module uim.platform.mes.domain.entities.change_request;

import uim.platform.mes.domain.types;

@safe:

struct ChangeRequest {
    ChangeRequestId id;
    TenantId tenantId;
    ProductId orderId;
    string title;
    string description;
    string priority;
    string status = "draft";
    string reason;
    string impact;
    string requestedBy;
    string assignedTo;
    string approvedBy;
    string affectedDocumentIds;
    string affectedBomIds;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}