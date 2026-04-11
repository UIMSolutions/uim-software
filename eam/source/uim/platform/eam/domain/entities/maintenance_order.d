/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.entities.maintenance_order;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct MaintenanceOrder {
    MaintenanceOrderId id;
    TenantId tenantId;
    string name;
    string description;
    string orderNumber;
    OrderType orderType = OrderType.corrective;
    OrderStatus status = OrderStatus.created;
    OrderPriority priority = OrderPriority.medium;
    EquipmentId equipmentId;
    FunctionalLocationId functionalLocationId;
    WorkCenterId workCenterId;
    MaintenanceNotificationId notificationId;
    string plannedStartDate;
    string plannedEndDate;
    string actualStartDate;
    string actualEndDate;
    string estimatedCost;
    string actualCost;
    string assignedTo;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
