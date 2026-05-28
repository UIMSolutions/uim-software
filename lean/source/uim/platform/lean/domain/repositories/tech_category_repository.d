/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.repositories.tech_category_repository;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

interface TechCategoryRepository {
    TechCategory[] findAll();
    TechCategory* findById(TechCategoryId id);
    TechCategory[] findByTenant(TenantId tenantId);
    TechCategory[] findByStatus(FactSheetStatus status);
    TechCategory[] findByParent(TechCategoryId parentId);
    void save(TechCategory category);
    void update(TechCategory category);
    void remove(TechCategoryId id);
}
