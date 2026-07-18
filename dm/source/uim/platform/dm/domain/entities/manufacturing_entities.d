module uim.platform.dm.domain.entities.manufacturing_entities;

import uim.platform.dm.domain.types;

@safe:

struct ProductionOrder {
    ProductionOrderId id;
    TenantId tenantId;
    string orderNumber;
    string materialId;
    string plant;
    string quantity;
    string unit;
    string scheduledStart;
    string scheduledEnd;
    OrderStatus status = OrderStatus.planned;
    string createdBy;
    string modifiedBy;
}

struct OperationActivity {
    OperationActivityId id;
    TenantId tenantId;
    string productionOrderId;
    string operationCode;
    string workCenterId;
    string sequence;
    string plannedDuration;
    OperationStatus status = OperationStatus.ready;
    string createdBy;
    string modifiedBy;
}

struct WorkCenter {
    WorkCenterId id;
    TenantId tenantId;
    string centerCode;
    string description;
    string plant;
    string capacity;
    string capacityUnit;
    string createdBy;
    string modifiedBy;
}

struct Resource {
    ResourceId id;
    TenantId tenantId;
    string resourceCode;
    string workCenterId;
    ResourceType resourceType = ResourceType.machine;
    string availability;
    string createdBy;
    string modifiedBy;
}

struct Material {
    MaterialId id;
    TenantId tenantId;
    string materialNumber;
    string description;
    string baseUnit;
    string revision;
    string createdBy;
    string modifiedBy;
}

struct ShopFloorControl {
    ShopFloorControlId id;
    TenantId tenantId;
    string productionOrderId;
    string dispatchRule;
    string priority;
    ControlMode mode = ControlMode.pull;
    string releaseStrategy;
    string createdBy;
    string modifiedBy;
}

struct WorkInstruction {
    WorkInstructionId id;
    TenantId tenantId;
    string operationActivityId;
    string title;
    string documentRef;
    string instructionVersion;
    string language;
    string createdBy;
    string modifiedBy;
}

struct QualityInspection {
    QualityInspectionId id;
    TenantId tenantId;
    string productionOrderId;
    string characteristic;
    string sampleSize;
    string resultValue;
    InspectionStatus status = InspectionStatus.pending;
    string inspector;
    string createdBy;
    string modifiedBy;
}

struct Nonconformance {
    NonconformanceId id;
    TenantId tenantId;
    string productionOrderId;
    string defectCode;
    string defectText;
    NonconformanceSeverity severity = NonconformanceSeverity.minor;
    string disposition;
    string createdBy;
    string modifiedBy;
}

struct GenealogyRecord {
    GenealogyRecordId id;
    TenantId tenantId;
    string productionOrderId;
    string parentSerial;
    string childSerial;
    string componentMaterialId;
    string assembledAt;
    string createdBy;
    string modifiedBy;
}
