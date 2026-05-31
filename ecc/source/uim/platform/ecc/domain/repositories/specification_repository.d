module uim.platform.ecc.domain.repositories.specification_repository;

import uim.platform.ecc.domain.entities.specification;
import uim.platform.ecc.domain.types;

@safe:

interface SpecificationRepository {
    Specification[] findAll();
    Specification* findById(SpecificationId id);
    void save(Specification value);
    void update(Specification value);
    void remove(SpecificationId id);
}