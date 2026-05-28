/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.release_record_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface ReleaseRecordRepository {
    ReleaseRecord[] findAll();
    ReleaseRecord* findById(ReleaseRecordId id);
    ReleaseRecord[] findByTenant(TenantId tenantId);
    ReleaseRecord[] findByStatus(ReleaseStatus releaseStatus);
    ReleaseRecord[] findByType(ReleaseType releaseType);
    void save(ReleaseRecord record);
    void update(ReleaseRecord record);
    void remove(ReleaseRecordId id);
}
