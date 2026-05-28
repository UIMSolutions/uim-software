/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.initiative_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface InitiativeRepository {
    Initiative[] findAll();
    Initiative* findById(InitiativeId id);
    Initiative[] findByTenant(TenantId tenantId);
    Initiative[] findByStatus(FactSheetStatus status);
    Initiative[] findByInitiativeStatus(InitiativeStatus initiativeStatus);
    Initiative[] findByPhase(InitiativePhase phase);
    void save(Initiative initiative);
    void update(Initiative initiative);
    void remove(InitiativeId id);
}
