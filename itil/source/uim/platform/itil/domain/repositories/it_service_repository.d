/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.it_service_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface ITServiceRepository {
    ITService[] findAll();
    ITService* findById(ITServiceId id);
    ITService[] findByTenant(TenantId tenantId);
    ITService[] findByStatus(RecordStatus status);
    ITService[] findByOwner(string owner);
    void save(ITService service);
    void update(ITService service);
    void remove(ITServiceId id);
}
