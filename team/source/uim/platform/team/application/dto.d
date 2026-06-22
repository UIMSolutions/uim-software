module uim.platform.team.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct PartDTO {
    string id;
    string tenantId;
    string number;
    string name;
    string description;
    string revision;
    string lifecycleState;
    string owningOrganization;
    string responsibleEngineer;
    string materialClass;
    string unitOfMeasure;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct BomLineDTO {
    string childPartId;
    string quantity;
    string unitOfMeasure;
    string findNumber;
    string effectivity;
}

struct BomDTO {
    string id;
    string tenantId;
    string parentPartId;
    string name;
    string revision;
    BomLineDTO[] lines;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct DocumentDTO {
    string id;
    string tenantId;
    string title;
    string docNumber;
    string revision;
    string docType;
    string fileName;
    string fileUri;
    string relatedPartId;
    string relatedChangeId;
    string owner;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ChangeRequestDTO {
    string id;
    string tenantId;
    string changeNumber;
    string title;
    string description;
    string state;
    string severity;
    string[] affectedPartIds;
    string[] affectedDocumentIds;
    string requestedBy;
    string approver;
    string targetImplementationDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ChangeImpactDTO {
    string changeId;
    string changeNumber;
    string state;
    string severity;
    long affectedParts;
    long affectedDocuments;
    long impactScore;
}

struct PlmSummaryDTO {
    long totalParts;
    long totalBoms;
    long totalDocuments;
    long totalChanges;
    long openChanges;
    long criticalChanges;
}
