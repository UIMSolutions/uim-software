module uim.platform.mes.domain.repositories.specification_repository;

import uim.platform.mes.domain.entities.specification;
import uim.platform.mes.domain.types;

@safe:

interface SpecificationRepository {
    Specification[] findAll();
    Specification* findById(SpecificationId id);
    void save(Specification value);
    void update(Specification value);
    void remove(SpecificationId id);
}