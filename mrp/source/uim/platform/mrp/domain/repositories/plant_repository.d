module uim.platform.mrp.domain.repositories.plant_repository;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

interface PlantRepository {
    Plant[] findAll();
    Plant* findById(PlantId id);
    Plant[] findByTenant(TenantId tenantId);
    void save(Plant plant);
    void update(Plant plant);
    void remove(PlantId id);
}
