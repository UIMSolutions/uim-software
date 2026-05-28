/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.data_object_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface DataObjectRepository {
    DataObject[] findAll();
    DataObject* findById(DataObjectId id);
    DataObject[] findByTenant(TenantId tenantId);
    DataObject[] findByStatus(FactSheetStatus status);
    DataObject[] findByClassification(DataClassification classification);
    DataObject[] findByApplication(LeanApplicationId appId);
    void save(DataObject dataObject);
    void update(DataObject dataObject);
    void remove(DataObjectId id);
}
