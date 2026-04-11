/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.repositories.tracking_model_repository;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

interface TrackingModelRepository {
    TrackingModel[] findAll();
    TrackingModel* findById(TrackingModelId id);
    TrackingModel[] findByTenant(TenantId tenantId);
    TrackingModel[] findByStatus(ModelStatus status);
    TrackingModel[] findByObjectType(string trackedObjectType);
    void save(TrackingModel model);
    void update(TrackingModel model);
    void remove(TrackingModelId id);
}
