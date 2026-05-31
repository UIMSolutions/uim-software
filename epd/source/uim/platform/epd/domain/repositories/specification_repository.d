module uim.platform.epd.domain.repositories.specification_repository;

import uim.platform.epd.domain.entities.specification;
import uim.platform.epd.domain.types;

@safe:

interface SpecificationRepository {
    Specification[] findAll();
    Specification* findById(SpecificationId id);
    void save(Specification value);
    void update(Specification value);
    void remove(SpecificationId id);
}