module uim.platform.ewm.domain.repositories.product_structure_repository;

import uim.platform.ewm.domain.entities.product_structure;
import uim.platform.ewm.domain.types;

@safe:

interface ProductStructureRepository {
    ProductStructure[] findAll();
    ProductStructure* findById(ProductStructureId id);
    void save(ProductStructure value);
    void update(ProductStructure value);
    void remove(ProductStructureId id);
}