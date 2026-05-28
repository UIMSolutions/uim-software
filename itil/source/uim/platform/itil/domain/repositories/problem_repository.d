/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.problem_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface ProblemRepository {
    Problem[] findAll();
    Problem* findById(ProblemId id);
    Problem[] findByTenant(TenantId tenantId);
    Problem[] findByStatus(ProblemStatus problemStatus);
    Problem[] findByPriority(Priority priority);
    Problem[] findByService(ITServiceId serviceId);
    void save(Problem problem);
    void update(Problem problem);
    void remove(ProblemId id);
}
