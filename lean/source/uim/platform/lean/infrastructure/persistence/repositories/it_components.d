/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.repositories.it_components;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryITComponentRepository : ITComponentRepository {
    private ITComponent[] store;

    ITComponent[] findAll() { return store; }

    ITComponent* findById(ITComponentId id) {
        foreach (ref c; store) if (c.id == id) return &c;
        return null;
    }

    ITComponent[] findByTenant(TenantId tenantId) {
        ITComponent[] result;
        foreach (ref c; store) if (c.tenantId == tenantId) result ~= c;
        return result;
    }

    ITComponent[] findByStatus(FactSheetStatus status) {
        ITComponent[] result;
        foreach (ref c; store) if (c.status == status) result ~= c;
        return result;
    }

    ITComponent[] findByLifecycleStatus(ITComponentLifecycleStatus lifecycleStatus) {
        ITComponent[] result;
        foreach (ref c; store) if (c.lifecycleStatus == lifecycleStatus) result ~= c;
        return result;
    }

    ITComponent[] findByType(ITComponentType componentType) {
        ITComponent[] result;
        foreach (ref c; store) if (c.componentType == componentType) result ~= c;
        return result;
    }

    ITComponent[] findByProvider(ProviderId providerId) {
        ITComponent[] result;
        foreach (ref c; store) if (c.providerId == providerId) result ~= c;
        return result;
    }

    ITComponent[] findByTechCategory(TechCategoryId categoryId) {
        ITComponent[] result;
        foreach (ref c; store) if (c.techCategoryId == categoryId) result ~= c;
        return result;
    }

    void save(ITComponent component) { store ~= component; }

    void update(ITComponent component) {
        foreach (ref c; store) if (c.id == component.id) { c = component; return; }
    }

    void remove(ITComponentId id) {
        import std.algorithm : remove;
        store = store.remove!(c => c.id == id);
    }
}
