/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.it_component_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface ITComponentRepository {
    ITComponent[] findAll();
    ITComponent* findById(ITComponentId id);
    ITComponent[] findByTenant(TenantId tenantId);
    ITComponent[] findByStatus(FactSheetStatus status);
    ITComponent[] findByLifecycleStatus(ITComponentLifecycleStatus lifecycleStatus);
    ITComponent[] findByType(ITComponentType componentType);
    ITComponent[] findByProvider(ProviderId providerId);
    ITComponent[] findByTechCategory(TechCategoryId categoryId);
    void save(ITComponent component);
    void update(ITComponent component);
    void remove(ITComponentId id);
}
