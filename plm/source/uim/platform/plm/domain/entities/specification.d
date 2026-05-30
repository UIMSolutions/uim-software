module uim.platform.plm.domain.entities.specification;

import uim.platform.plm.domain.types;

@safe:

struct Specification {
    SpecificationId id;
    TenantId tenantId;
    ProductId productId;
    string name;
    string description;
    string specificationType;
    string status = "draft";
    string specificationNumber;
    string property;
    string targetValue;
    string unit;
    string lowerLimit;
    string upperLimit;
    string testMethod;
    string complianceStandard;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}