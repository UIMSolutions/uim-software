/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.infrastructure.persistence.memory.maintenance_notifications;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class MemoryMaintenanceNotificationRepository : MaintenanceNotificationRepository {
    private MaintenanceNotification[] store;

    MaintenanceNotification[] findAll() { return store; }

    MaintenanceNotification* findById(MaintenanceNotificationId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    MaintenanceNotification[] findByTenant(TenantId tenantId) {
        MaintenanceNotification[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    MaintenanceNotification[] findByStatus(NotificationStatus status) {
        MaintenanceNotification[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    MaintenanceNotification[] findByEquipment(EquipmentId equipmentId) {
        MaintenanceNotification[] result;
        foreach (ref e; store)
            if (e.equipmentId == equipmentId) result ~= e;
        return result;
    }

    MaintenanceNotification[] findByType(NotificationType notificationType) {
        MaintenanceNotification[] result;
        foreach (ref e; store)
            if (e.notificationType == notificationType) result ~= e;
        return result;
    }

    void save(MaintenanceNotification notification) { store ~= notification; }

    void update(MaintenanceNotification notification) {
        foreach (ref e; store)
            if (e.id == notification.id) { e = notification; return; }
    }

    void remove(MaintenanceNotificationId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
