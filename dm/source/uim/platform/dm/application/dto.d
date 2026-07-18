module uim.platform.dm.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct ProductionOrderDTO {
    string id;
    string tenantId;
    string orderNumber;
    string materialId;
    string plant;
    string quantity;
    string unit;
    string scheduledStart;
    string scheduledEnd;
    string status;
    string createdBy;
    string modifiedBy;
}

struct OperationActivityDTO {
    string id;
    string tenantId;
    string productionOrderId;
    string operationCode;
    string workCenterId;
    string sequence;
    string plannedDuration;
    string status;
    string createdBy;
    string modifiedBy;
}

struct WorkCenterDTO {
    string id;
    string tenantId;
    string centerCode;
    string description;
    string plant;
    string capacity;
    string capacityUnit;
    string createdBy;
    string modifiedBy;
}

struct ResourceDTO {
    string id;
    string tenantId;
    string resourceCode;
    string workCenterId;
    string resourceType;
    string availability;
    string createdBy;
    string modifiedBy;
}

struct MaterialDTO {
    string id;
    string tenantId;
    string materialNumber;
    string description;
    string baseUnit;
    string revision;
    string createdBy;
    string modifiedBy;
}

struct ShopFloorControlDTO {
    string id;
    string tenantId;
    string productionOrderId;
    string dispatchRule;
    string priority;
    string mode;
    string releaseStrategy;
    string createdBy;
    string modifiedBy;
}

struct WorkInstructionDTO {
    string id;
    string tenantId;
    string operationActivityId;
    string title;
    string documentRef;
    string version;
    string language;
    string createdBy;
    string modifiedBy;
}

struct QualityInspectionDTO {
    string id;
    string tenantId;
    string productionOrderId;
    string characteristic;
    string sampleSize;
    string resultValue;
    string status;
    string inspector;
    string createdBy;
    string modifiedBy;
}

struct NonconformanceDTO {
    string id;
    string tenantId;
    string productionOrderId;
    string defectCode;
    string defectText;
    string severity;
    string disposition;
    string createdBy;
    string modifiedBy;
}

struct GenealogyRecordDTO {
    string id;
    string tenantId;
    string productionOrderId;
    string parentSerial;
    string childSerial;
    string componentMaterialId;
    string assembledAt;
    string createdBy;
    string modifiedBy;
}
