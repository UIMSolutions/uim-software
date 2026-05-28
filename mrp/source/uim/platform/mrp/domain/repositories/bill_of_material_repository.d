module uim.platform.mrp.domain.repositories.bill_of_material_repository;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

interface BillOfMaterialRepository {
    BillOfMaterial[] findAll();
    BillOfMaterial* findById(BillOfMaterialId id);
    BillOfMaterial[] findByTenant(TenantId tenantId);
    BillOfMaterial[] findByPlant(PlantId plantId);
    BillOfMaterial[] findByParentMaterial(MaterialId materialId);
    BillOfMaterial[] findByComponentMaterial(MaterialId materialId);
    void save(BillOfMaterial bom);
    void update(BillOfMaterial bom);
    void remove(BillOfMaterialId id);
}
