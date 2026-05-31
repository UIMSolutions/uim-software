module uim.platform.ewm.domain.entities.change_request;

import uim.platform.ewm.domain.types;

@safe:

struct ChangeRequest {
    ChangeRequestId id;
    TenantId tenantId;
    ProductId warehouseId;
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