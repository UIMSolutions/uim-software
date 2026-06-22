module uim.platform.mii.domain.entities.specification;

import uim.platform.mii.domain.types;

@safe:

struct Specification {
    SpecificationId id;
    TenantId tenantId;
    ProductId messageId;
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