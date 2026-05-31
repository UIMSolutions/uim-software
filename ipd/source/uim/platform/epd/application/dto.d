module uim.platform.epd.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct ProductDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string productNumber;
    string productType;
    string lifecycleStatus;
    string category;
    string baseUnit;
    string validFrom;
    string validTo;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct BillOfMaterialDTO {
    string id;
    string tenantId;
    string productId;
    string name;
    string description;
    string bomType;
    string revision;
    string usage;
    string plant;
    string baseQuantity;
    string baseUnit;
    string isActive;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ChangeRequestDTO {
    string id;
    string tenantId;
    string productId;
    string title;
    string description;
    string priority;
    string status;
    string reason;
    string impact;
    string requestedBy;
    string assignedTo;
    string approvedBy;
    string affectedDocumentIds;
    string affectedBomIds;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct DocumentDTO {
    string id;
    string tenantId;
    string productId;
    string name;
    string description;
    string documentType;
    string status;
    string documentNumber;
    string fileName;
    string mimeType;
    string language;
    string author;
    string approvedBy;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct SpecificationDTO {
    string id;
    string tenantId;
    string productId;
    string name;
    string description;
    string specificationType;
    string status;
    string specificationNumber;
    string property;
    string targetValue;
    string unit;
    string lowerLimit;
    string upperLimit;
    string testMethod;
    string complianceStandard;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct RecipeDTO {
    string id;
    string tenantId;
    string productId;
    string name;
    string description;
    string recipeType;
    string status;
    string recipeNumber;
    string yieldValue;
    string yieldUnit;
    string batchSize;
    string batchUnit;
    string shelfLife;
    string storageConditions;
    string ingredients;
    string instructions;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct CollaborationDTO {
    string id;
    string tenantId;
    string productId;
    string title;
    string description;
    string collaborationType;
    string status;
    string assignedTo;
    string participants;
    string dueDate;
    string resolvedDate;
    string resolution;
    string relatedDocumentId;
    string relatedChangeRequestId;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ProductStructureDTO {
    string id;
    string tenantId;
    string productId;
    string name;
    string description;
    string nodeType;
    string parentNodeId;
    string childNodeIds;
    string quantity;
    string mandatory;
    string status;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
