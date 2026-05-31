module uim.platform.ibp.domain.repositories.specification_repository;

import uim.platform.ibp.domain.entities.specification;
import uim.platform.ibp.domain.types;

@safe:

interface SpecificationRepository {
    Specification[] findAll();
    Specification* findById(SpecificationId id);
    void save(Specification value);
    void update(Specification value);
    void remove(SpecificationId id);
}