module uim.platform.ppm.domain.repositories.portfolio_repository;

import uim.platform.ppm.domain.entities.portfolio;
import uim.platform.ppm.domain.types;

@safe:

interface PortfolioRepository {
    Portfolio[] findAll();
    Portfolio* findById(PortfolioId id);
    void save(Portfolio value);
    void update(Portfolio value);
    void remove(PortfolioId id);
}
