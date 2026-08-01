module uim.platform.pp.domain.entities.pp_object;

@safe:

enum PPBusinessObjectType : string {
    material = "materials",
    plant = "plants",
    workCenter = "work-centers",
    productionVersion = "production-versions",
    billOfMaterial = "bills-of-material",
    routing = "routings",
    mrpArea = "mrp-areas",
    demandProgram = "demand-programs",
    plannedOrder = "planned-orders",
    productionOrder = "production-orders",
    orderOperation = "order-operations",
    confirmation = "confirmations",
    capacityRequirement = "capacity-requirements",
    mrpRun = "mrp-runs"
}

struct PPObject {
    string id;
    string objectType;
    string tenantId;
    string plantId;
    string materialId;
    string orderId;
    string name;
    string status;
    string description;
    string startDate;
    string endDate;
    string quantity;
    string uom;
    string priority;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
    string[string] attributes;
}
