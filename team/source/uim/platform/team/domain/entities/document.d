module uim.platform.team.domain.entities.document;

import uim.platform.team.domain.types;

@safe:

struct Document {
    DocumentId id;
    TenantId tenantId;
    string title;
    string docNumber;
    string revision;
    DocumentType docType = DocumentType.specification;
    string fileName;
    string fileUri;
    PartId relatedPartId;
    ChangeId relatedChangeId;
    string owner;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
