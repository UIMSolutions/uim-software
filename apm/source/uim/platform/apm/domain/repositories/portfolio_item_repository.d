module uim.platform.apm.domain.repositories.portfolio_item_repository;

import uim.platform.apm.domain;

@safe:

interface PortfolioItemRepository {
    ApplicationPortfolioItem[] findAll();
    ApplicationPortfolioItem[] findByTenant(TenantId tenantId);
    ApplicationPortfolioItem* findById(PortfolioItemId id);
    void save(ApplicationPortfolioItem item);
    void update(ApplicationPortfolioItem item);
    void remove(PortfolioItemId id);
}
