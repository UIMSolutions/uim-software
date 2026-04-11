/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.repositories.maintenance_item_repository;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

interface MaintenanceItemRepository {
    MaintenanceItem[] findAll();
    MaintenanceItem* findById(MaintenanceItemId id);
    MaintenanceItem[] findByTenant(TenantId tenantId);
    MaintenanceItem[] findByPlan(MaintenancePlanId planId);
    MaintenanceItem[] findByEquipment(EquipmentId equipmentId);
    void save(MaintenanceItem item);
    void update(MaintenanceItem item);
    void remove(MaintenanceItemId id);
}
