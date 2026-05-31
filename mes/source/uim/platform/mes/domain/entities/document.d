module uim.platform.mes.domain.entities.document;

import uim.platform.mes.domain.types;

@safe:

struct Document {
    DocumentId id;
    TenantId tenantId;
    ProductId orderId;
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