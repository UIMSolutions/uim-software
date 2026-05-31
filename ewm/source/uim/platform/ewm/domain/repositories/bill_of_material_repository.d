module uim.platform.ewm.domain.repositories.bill_of_material_repository;

import uim.platform.ewm.domain.entities.bill_of_material;
import uim.platform.ewm.domain.types;

@safe:

interface BillOfMaterialRepository {
    BillOfMaterial[] findAll();
    BillOfMaterial* findById(BillOfMaterialId id);
    void save(BillOfMaterial value);
    void update(BillOfMaterial value);
    void remove(BillOfMaterialId id);
}