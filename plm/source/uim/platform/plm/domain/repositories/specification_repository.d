module uim.platform.plm.domain.repositories.specification_repository;

import uim.platform.plm.domain.entities.specification;
import uim.platform.plm.domain.types;

@safe:

interface SpecificationRepository {
    Specification[] findAll();
    Specification* findById(SpecificationId id);
    void save(Specification value);
    void update(Specification value);
    void remove(SpecificationId id);
}