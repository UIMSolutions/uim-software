module uim.platform.team.domain.entities.change_request;

import uim.platform.team.domain.types;

@safe:

struct ChangeRequest {
    ChangeId id;
    TenantId tenantId;
    string changeNumber;
    string title;
    string description;
    ChangeState state = ChangeState.draft;
    Severity severity = Severity.medium;
    PartId[] affectedPartIds;
    DocumentId[] affectedDocumentIds;
    string requestedBy;
    string approver;
    string targetImplementationDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
