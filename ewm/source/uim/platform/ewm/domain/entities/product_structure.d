module uim.platform.ewm.domain.entities.product_structure;

import uim.platform.ewm.domain.types;

@safe:

struct ProductStructure {
    ProductStructureId id;
    TenantId tenantId;
    ProductId warehouseId;
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