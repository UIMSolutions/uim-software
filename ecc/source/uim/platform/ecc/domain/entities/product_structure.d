module uim.platform.ecc.domain.entities.product_structure;

import uim.platform.ecc.domain.types;

@safe:

struct ProductStructure {
    ProductStructureId id;
    TenantId tenantId;
    ProductId productId;
    string name;
    string description;
    string nodeType;
    string parentNodeId;
    string childNodeIds;
    string quantity;
    string mandatory;
    string status = "draft";
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}