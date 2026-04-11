/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.repositories.maintenance_notification_repository;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

interface MaintenanceNotificationRepository {
    MaintenanceNotification[] findAll();
    MaintenanceNotification* findById(MaintenanceNotificationId id);
    MaintenanceNotification[] findByTenant(TenantId tenantId);
    MaintenanceNotification[] findByStatus(NotificationStatus status);
    MaintenanceNotification[] findByEquipment(EquipmentId equipmentId);
    MaintenanceNotification[] findByType(NotificationType notificationType);
    void save(MaintenanceNotification notification);
    void update(MaintenanceNotification notification);
    void remove(MaintenanceNotificationId id);
}
