module uim.platform.ewm.domain.entities.collaboration;

import uim.platform.ewm.domain.types;

@safe:

struct Collaboration {
    CollaborationId id;
    TenantId tenantId;
    ProductId warehouseId;
    string title;
    string description;
    string collaborationType;
    string status = "open";
    string assignedTo;
    string participants;
    string dueDate;
    string resolvedDate;
    string resolution;
    string relatedDocumentId;
    string relatedChangeRequestId;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}