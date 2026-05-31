module uim.platform.mes.domain.repositories.product_structure_repository;

import uim.platform.mes.domain.entities.product_structure;
import uim.platform.mes.domain.types;

@safe:

interface ProductStructureRepository {
    ProductStructure[] findAll();
    ProductStructure* findById(ProductStructureId id);
    void save(ProductStructure value);
    void update(ProductStructure value);
    void remove(ProductStructureId id);
}