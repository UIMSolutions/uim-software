module uim.platform.ewm.domain.repositories.specification_repository;

import uim.platform.ewm.domain.entities.specification;
import uim.platform.ewm.domain.types;

@safe:

interface SpecificationRepository {
    Specification[] findAll();
    Specification* findById(SpecificationId id);
    void save(Specification value);
    void update(Specification value);
    void remove(SpecificationId id);
}