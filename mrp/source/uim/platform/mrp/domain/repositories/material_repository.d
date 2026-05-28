module uim.platform.mrp.domain.repositories.material_repository;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

interface MaterialRepository {
    Material[] findAll();
    Material* findById(MaterialId id);
    Material[] findByTenant(TenantId tenantId);
    Material[] findByPlant(PlantId plantId);
    void save(Material material);
    void update(Material material);
    void remove(MaterialId id);
}
