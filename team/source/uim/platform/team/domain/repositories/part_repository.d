module uim.platform.team.domain.repositories.part_repository;

import uim.platform.team.domain;

@safe:

interface PartRepository {
    Part[] findAll();
    Part[] findByTenant(TenantId tenantId);
    Part* findById(PartId id);
    void save(Part part);
    void update(Part part);
    void remove(PartId id);
}
