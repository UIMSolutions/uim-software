module uim.platform.mrp.application.dto;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct MaterialDTO {
    string id;
    string tenantId;
    string plantId;
    string name;
    string description;
    string materialNumber;
    string baseUnit;
    string mrpProcedure;
    string lotSizingProcedure;
    string procurementType;
    string status;
    string safetyStock;
    string reorderPoint;
    string lotSize;
    string minimumLotSize;
    string independentDemand;
    string planningTimeFenceDays;
    string inHouseProductionTimeDays;
    string plannedDeliveryTimeDays;
    string grProcessingTimeDays;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct PlantDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string plantCode;
    string planningScope;
    string mrpAreas;
    string companyCode;
    string country;
    string timezone;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct BillOfMaterialDTO {
    string id;
    string tenantId;
    string plantId;
    string name;
    string description;
    string parentMaterialId;
    string componentMaterialId;
    string componentQuantity;
    string baseQuantity;
    string scrapPercent;
    string validFrom;
    string validTo;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct InventoryPositionDTO {
    string id;
    string tenantId;
    string plantId;
    string materialId;
    string stockSegment;
    string storageLocation;
    string onHandQuantity;
    string scheduledReceipts;
    string reservedQuantity;
    string openPurchaseOrders;
    string openProductionOrders;
    string snapshotDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct MrpRunDTO {
    string id;
    string tenantId;
    string plantId;
    string name;
    string description;
    string mode;
    string status;
    string planningDate;
    string horizonDays;
    string includeExternalRequirements;
    string includeDependentRequirements;
    string includeSafetyStock;
    string generatedProposalCount;
    string executedBy;
    string executedAt;
    string createdAt;
    string modifiedAt;
}

struct ProcurementProposalDTO {
    string id;
    string tenantId;
    string mrpRunId;
    string plantId;
    string materialId;
    string proposalType;
    string status;
    string quantity;
    string dueDate;
    string source;
    string exceptionMessage;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
