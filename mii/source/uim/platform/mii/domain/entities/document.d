module uim.platform.mii.domain.entities.document;

import uim.platform.mii.domain.types;

@safe:

struct Document {
    DocumentId id;
    TenantId tenantId;
    ProductId messageId;
    string name;
    string description;
    string documentType;
    string status = "draft";
    string documentNumber;
    string fileName;
    string mimeType;
    string language;
    string author;
    string approvedBy;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}