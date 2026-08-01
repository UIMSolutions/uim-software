module uim.platform.mm.application.dto;

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct MaterialDTO {
    string id;
    string tenantId;
    string materialNumber;
    string description;
    string baseUnit;
    string materialType;
    string materialGroup;
    string valuationClass;
    string status;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct PlantDTO {
    string id;
    string tenantId;
    string plantCode;
    string name;
    string companyCode;
    string country;
    string purchasingOrg;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct StorageLocationDTO {
    string id;
    string tenantId;
    string plantId;
    string storageLocationCode;
    string name;
    string description;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct VendorDTO {
    string id;
    string tenantId;
    string vendorNumber;
    string name;
    string purchasingOrg;
    string currency;
    string paymentTerms;
    string incoterms;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct PurchasingInfoRecordDTO {
    string id;
    string tenantId;
    string materialId;
    string vendorId;
    string plantId;
    string purchasingOrg;
    string orderUnit;
    string netPrice;
    string currency;
    string leadTimeDays;
    string minimumOrderQuantity;
    string sourceListNote;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct PurchaseRequisitionDTO {
    string id;
    string tenantId;
    string materialId;
    string plantId;
    string storageLocationId;
    string quantity;
    string unit;
    string requiredDate;
    string accountAssignment;
    string status;
    string requestedBy;
    string sourceVendorId;
    string createdAt;
    string modifiedAt;
}

struct PurchaseOrderDTO {
    string id;
    string tenantId;
    string vendorId;
    string plantId;
    string purchasingOrg;
    string currency;
    string status;
    string referenceRequisitionId;
    string orderedBy;
    string lineMaterialId;
    string lineQuantity;
    string receivedQuantity;
    string unit;
    string netPrice;
    string deliveryDate;
    string createdAt;
    string modifiedAt;
}

struct GoodsReceiptDTO {
    string id;
    string tenantId;
    string purchaseOrderId;
    string plantId;
    string storageLocationId;
    string materialId;
    string movementType;
    string quantity;
    string postedBy;
    string postingDate;
    string documentDate;
    string createdAt;
    string modifiedAt;
}

struct StockItemDTO {
    string id;
    string tenantId;
    string materialId;
    string plantId;
    string storageLocationId;
    string unrestrictedUseQty;
    string qualityInspectionQty;
    string blockedQty;
    string openInboundQty;
    string lastMovementAt;
    string modifiedBy;
    string modifiedAt;
}