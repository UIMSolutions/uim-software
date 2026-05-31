module uim.platform.ecc.domain.repositories.bill_of_material_repository;

import uim.platform.ecc.domain.entities.bill_of_material;
import uim.platform.ecc.domain.types;

@safe:

interface BillOfMaterialRepository {
    BillOfMaterial[] findAll();
    BillOfMaterial* findById(BillOfMaterialId id);
    void save(BillOfMaterial value);
    void update(BillOfMaterial value);
    void remove(BillOfMaterialId id);
}