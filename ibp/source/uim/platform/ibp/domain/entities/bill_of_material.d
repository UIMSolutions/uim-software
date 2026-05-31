module uim.platform.ibp.domain.entities.bill_of_material;

import uim.platform.ibp.domain.types;

@safe:

struct BillOfMaterial {
    BillOfMaterialId id;
    TenantId tenantId;
    ProductId demandPlanId;
    string name;
    string description;
    string bomType;
    string revision;
    string usage;
    string plant;
    string baseQuantity;
    string baseUnit;
    string isActive = "true";
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}