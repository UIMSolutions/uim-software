/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.persistence.memory.tracking_models;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class MemoryTrackingModelRepository : TrackingModelRepository {
    private TrackingModel[] store;

    TrackingModel[] findAll() { return store; }

    TrackingModel* findById(TrackingModelId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    TrackingModel[] findByTenant(TenantId tenantId) {
        TrackingModel[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    TrackingModel[] findByStatus(ModelStatus status) {
        TrackingModel[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    TrackingModel[] findByObjectType(string trackedObjectType) {
        TrackingModel[] result;
        foreach (ref e; store)
            if (e.trackedObjectType == trackedObjectType) result ~= e;
        return result;
    }

    void save(TrackingModel model) { store ~= model; }

    void update(TrackingModel model) {
        foreach (ref e; store)
            if (e.id == model.id) { e = model; return; }
    }

    void remove(TrackingModelId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
