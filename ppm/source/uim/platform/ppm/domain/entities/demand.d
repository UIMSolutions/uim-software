module uim.platform.ppm.domain.entities.demand;

import uim.platform.ppm.domain.types;

@safe:

struct Demand {
    DemandId id;
    TenantId tenantId;
    PortfolioId portfolioId;
    string title;
    string description;
    string source;
    string businessValue;
    string priority;
    string status = "submitted";
    string requestedBy;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
