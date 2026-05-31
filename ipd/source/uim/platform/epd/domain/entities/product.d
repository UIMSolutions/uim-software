module uim.platform.epd.domain.entities.product;

import uim.platform.epd.domain.types;

@safe:

struct Product {
    ProductId id;
    TenantId tenantId;
    string name;
    string description;
    string productNumber;
    string productType;
    string lifecycleStatus = "draft";
    string category;
    string baseUnit;
    string validFrom;
    string validTo;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}