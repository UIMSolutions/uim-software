module uim.platform.team.domain.repositories.bom_repository;

import uim.platform.team.domain;

@safe:

interface BomRepository {
    Bom[] findAll();
    Bom[] findByTenant(TenantId tenantId);
    Bom* findById(BomId id);
    Bom[] findByParentPart(PartId parentPartId);
    void save(Bom bom);
    void update(Bom bom);
    void remove(BomId id);
}
