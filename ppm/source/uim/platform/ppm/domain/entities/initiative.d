module uim.platform.ppm.domain.entities.initiative;

import uim.platform.ppm.domain.types;

@safe:

struct Initiative {
    InitiativeId id;
    TenantId tenantId;
    PortfolioId portfolioId;
    string title;
    string description;
    string category;
    string priority;
    string status = "new";
    string sponsor;
    string expectedBenefits;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
