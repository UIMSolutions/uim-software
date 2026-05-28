module uim.platform.mrp.domain.repositories.mrp_run_repository;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

interface MrpRunRepository {
    MrpRun[] findAll();
    MrpRun* findById(MrpRunId id);
    MrpRun[] findByTenant(TenantId tenantId);
    MrpRun[] findByPlant(PlantId plantId);
    MrpRun[] findByStatus(RunStatus status);
    void save(MrpRun mrpRun);
    void update(MrpRun mrpRun);
    void remove(MrpRunId id);
}
