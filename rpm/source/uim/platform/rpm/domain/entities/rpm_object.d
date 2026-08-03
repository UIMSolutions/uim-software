module uim.platform.rpm.domain.entities.rpm_object;

@safe:

enum RpmBusinessObjectType : string {
    packagingMaterials = "packaging-materials",
    packagingPools = "packaging-pools",
    packagingOwners = "packaging-owners",
    partners = "partners",
    locations = "locations",
    depots = "depots",
    lanes = "lanes",
    shipmentOrders = "shipment-orders",
    shipmentItems = "shipment-items",
    returnOrders = "return-orders",
    returnItems = "return-items",
    rentalContracts = "rental-contracts",
    qualityInspections = "quality-inspections",
    cleaningOrders = "cleaning-orders",
    repairOrders = "repair-orders",
    transferOrders = "transfer-orders",
    inventorySnapshots = "inventory-snapshots",
    cycleCounts = "cycle-counts",
    serialAssets = "serial-assets",
    telemetryEvents = "telemetry-events",
    alerts = "alerts",
    invoices = "invoices",
    apiDefinitions = "api-definitions",
    auditEntries = "audit-entries"
}

enum RpmOperationType : string {
    checkOut = "check-out",
    checkIn = "check-in",
    transfer = "transfer",
    clean = "clean",
    repair = "repair",
    inspect = "inspect"
}

struct RpmObject {
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
    string createdAt;
    string modifiedAt;
    string[string] metadata;
}
