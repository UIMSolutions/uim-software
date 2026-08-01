module uim.platform.mm.domain.entities;

import uim.platform.mm.domain.types;

struct Material {
    MaterialId id;
    TenantId tenantId;
    string materialNumber;
    string description;
    string baseUnit;
    MaterialType materialType = MaterialType.rawMaterial;
    string materialGroup;
    string valuationClass;
    MaterialStatus status = MaterialStatus.active;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct Plant {
    PlantId id;
    TenantId tenantId;
    string plantCode;
    string name;
    string companyCode;
    string country;
    string purchasingOrg;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct StorageLocation {
    StorageLocationId id;
    TenantId tenantId;
    PlantId plantId;
    string storageLocationCode;
    string name;
    string description;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct SupplierVendor {
    VendorId id;
    TenantId tenantId;
    string vendorNumber;
    string name;
    string purchasingOrg;
    string currency;
    string paymentTerms;
    string incoterms;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct PurchasingInfoRecord {
    PurchasingInfoRecordId id;
    TenantId tenantId;
    MaterialId materialId;
    VendorId vendorId;
    PlantId plantId;
    string purchasingOrg;
    string orderUnit;
    string netPrice;
    string currency;
    string leadTimeDays;
    string minimumOrderQuantity;
    string sourceListNote;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct PurchaseRequisition {
    PurchaseRequisitionId id;
    TenantId tenantId;
    MaterialId materialId;
    PlantId plantId;
    StorageLocationId storageLocationId;
    string quantity;
    string unit;
    string requiredDate;
    string accountAssignment;
    PurchaseRequisitionStatus status = PurchaseRequisitionStatus.open;
    string requestedBy;
    VendorId sourceVendorId;
    string createdAt;
    string modifiedAt;
}

struct PurchaseOrder {
    PurchaseOrderId id;
    TenantId tenantId;
    VendorId vendorId;
    PlantId plantId;
    string purchasingOrg;
    string currency;
    PurchaseOrderStatus status = PurchaseOrderStatus.created;
    PurchaseRequisitionId referenceRequisitionId;
    string orderedBy;
    MaterialId lineMaterialId;
    string lineQuantity;
    string receivedQuantity;
    string unit;
    string netPrice;
    string deliveryDate;
    string createdAt;
    string modifiedAt;
}

struct GoodsReceipt {
    GoodsReceiptId id;
    TenantId tenantId;
    PurchaseOrderId purchaseOrderId;
    PlantId plantId;
    StorageLocationId storageLocationId;
    MaterialId materialId;
    MovementType movementType = MovementType.goodsReceipt;
    string quantity;
    string postedBy;
    string postingDate;
    string documentDate;
    string createdAt;
    string modifiedAt;
}

struct StockItem {
    StockItemId id;
    TenantId tenantId;
    MaterialId materialId;
    PlantId plantId;
    StorageLocationId storageLocationId;
    string unrestrictedUseQty;
    string qualityInspectionQty;
    string blockedQty;
    string openInboundQty;
    string lastMovementAt;
    string modifiedBy;
    string modifiedAt;
}