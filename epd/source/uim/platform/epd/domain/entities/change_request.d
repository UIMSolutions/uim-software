module uim.platform.epd.domain.entities.change_request;

import uim.platform.epd.domain.types;

@safe:

struct ChangeRequest {
    ChangeRequestId id;
    TenantId tenantId;
    ProductId productId;
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