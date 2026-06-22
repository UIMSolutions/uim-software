module uim.platform.ppm.domain.entities.portfolio;

import uim.platform.ppm.domain.types;

@safe:

struct Portfolio {
    PortfolioId id;
    TenantId tenantId;
    string name;
    string description;
    string strategicTheme;
    string status = "planning";
    string planningHorizon;
    string owner;
    string budgetAmount;
    string currency;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
