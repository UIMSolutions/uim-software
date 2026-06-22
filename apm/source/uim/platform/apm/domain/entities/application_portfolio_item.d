module uim.platform.apm.domain.entities.application_portfolio_item;

import uim.platform.apm.domain.types;

@safe:

struct ApplicationPortfolioItem {
    PortfolioItemId id;
    TenantId tenantId;
    string name;
    string description;
    string businessCapability;
    string organization;
    LifecyclePhase lifecyclePhase = LifecyclePhase.maintain;
    BusinessCriticality businessCriticality = BusinessCriticality.medium;
    string annualCostUsd;
    string owner;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
