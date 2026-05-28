/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.change_record_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface ChangeRecordRepository {
    ChangeRecord[] findAll();
    ChangeRecord* findById(ChangeRecordId id);
    ChangeRecord[] findByTenant(TenantId tenantId);
    ChangeRecord[] findByStatus(ChangeStatus changeStatus);
    ChangeRecord[] findByType(ChangeType changeType);
    ChangeRecord[] findByRisk(ChangeRisk risk);
    void save(ChangeRecord record);
    void update(ChangeRecord record);
    void remove(ChangeRecordId id);
}
