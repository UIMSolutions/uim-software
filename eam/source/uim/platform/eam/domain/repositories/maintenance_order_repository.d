/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.repositories.maintenance_order_repository;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

interface MaintenanceOrderRepository {
    MaintenanceOrder[] findAll();
    MaintenanceOrder* findById(MaintenanceOrderId id);
    MaintenanceOrder[] findByTenant(TenantId tenantId);
    MaintenanceOrder[] findByStatus(OrderStatus status);
    MaintenanceOrder[] findByEquipment(EquipmentId equipmentId);
    MaintenanceOrder[] findByType(OrderType orderType);
    void save(MaintenanceOrder order);
    void update(MaintenanceOrder order);
    void remove(MaintenanceOrderId id);
}
