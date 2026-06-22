module uim.platform.mii.domain.entities.bill_of_material;

import uim.platform.mii.domain.types;

@safe:

struct BillOfMaterial {
    BillOfMaterialId id;
    TenantId tenantId;
    ProductId messageId;
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