module uim.platform.mii.domain.repositories.specification_repository;

import uim.platform.mii.domain.entities.specification;
import uim.platform.mii.domain.types;

@safe:

interface SpecificationRepository {
    Specification[] findAll();
    Specification* findById(SpecificationId id);
    void save(Specification value);
    void update(Specification value);
    void remove(SpecificationId id);
}