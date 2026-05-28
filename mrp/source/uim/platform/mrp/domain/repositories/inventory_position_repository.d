module uim.platform.mrp.domain.repositories.inventory_position_repository;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

interface InventoryPositionRepository {
    InventoryPosition[] findAll();
    InventoryPosition* findById(InventoryPositionId id);
    InventoryPosition[] findByTenant(TenantId tenantId);
    InventoryPosition[] findByPlant(PlantId plantId);
    InventoryPosition[] findByMaterial(MaterialId materialId);
    InventoryPosition* findByMaterialAndPlant(MaterialId materialId, PlantId plantId);
    void save(InventoryPosition inventoryPosition);
    void update(InventoryPosition inventoryPosition);
    void remove(InventoryPositionId id);
}
