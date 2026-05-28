/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.improvement_item_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface ImprovementItemRepository {
    ImprovementItem[] findAll();
    ImprovementItem* findById(ImprovementItemId id);
    ImprovementItem[] findByTenant(TenantId tenantId);
    ImprovementItem[] findByStatus(ImprovementStatus improvementStatus);
    ImprovementItem[] findByPriority(Priority priority);
    ImprovementItem[] findByService(ITServiceId serviceId);
    void save(ImprovementItem item);
    void update(ImprovementItem item);
    void remove(ImprovementItemId id);
}
