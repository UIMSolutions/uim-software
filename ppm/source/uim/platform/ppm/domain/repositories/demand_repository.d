module uim.platform.ppm.domain.repositories.demand_repository;

import uim.platform.ppm.domain.entities.demand;
import uim.platform.ppm.domain.types;

@safe:

interface DemandRepository {
    Demand[] findAll();
    Demand* findById(DemandId id);
    void save(Demand value);
    void update(Demand value);
    void remove(DemandId id);
}
