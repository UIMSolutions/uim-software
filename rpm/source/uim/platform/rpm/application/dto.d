module uim.platform.rpm.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct RpmObjectDTO {
    string id;
    string objectType;
    string tenantId;
    string technicalName;
    string businessName;
    string lifecycleState;
    string parentId;
    string owner;
    string locationId;
    string partnerId;
    string referenceId;
    string unitOfMeasure;
    long quantity;
    string description;
    string externalReference;
    string createdBy;
    string modifiedBy;
    string[string] metadata;
}

struct OperationRequestDTO {
    string operationType;
    string poolId;
    string packagingMaterialId;
    string assetId;
    string fromLocationId;
    string toLocationId;
    string partnerId;
    long quantity;
    string referenceId;
    string executedBy;
    string notes;
}

struct KpiQueryDTO {
    string fromDate;
    string toDate;
    string tenantId;
}
