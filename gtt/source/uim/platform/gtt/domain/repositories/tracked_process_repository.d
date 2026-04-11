/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.repositories.tracked_process_repository;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

interface TrackedProcessRepository {
    TrackedProcess[] findAll();
    TrackedProcess* findById(TrackedProcessId id);
    TrackedProcess[] findByTenant(TenantId tenantId);
    TrackedProcess[] findByStatus(ProcessStatus status);
    TrackedProcess[] findByProcessType(ProcessType processType);
    void save(TrackedProcess process);
    void update(TrackedProcess process);
    void remove(TrackedProcessId id);
}
