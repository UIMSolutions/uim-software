module uim.platform.mes.domain.entities.product_structure;

import uim.platform.mes.domain.types;

@safe:

struct ProductStructure {
    ProductStructureId id;
    TenantId tenantId;
    ProductId orderId;
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