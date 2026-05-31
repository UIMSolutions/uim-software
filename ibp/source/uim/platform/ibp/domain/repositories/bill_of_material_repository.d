module uim.platform.ibp.domain.repositories.bill_of_material_repository;

import uim.platform.ibp.domain.entities.bill_of_material;
import uim.platform.ibp.domain.types;

@safe:

interface BillOfMaterialRepository {
    BillOfMaterial[] findAll();
    BillOfMaterial* findById(BillOfMaterialId id);
    void save(BillOfMaterial value);
    void update(BillOfMaterial value);
    void remove(BillOfMaterialId id);
}