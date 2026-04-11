/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.application.usecases.manage.manage_maintenance_notifications;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class ManageMaintenanceNotificationsUseCase : UIMUseCase {
    private MaintenanceNotificationRepository repo;

    this(MaintenanceNotificationRepository repo) {
        this.repo = repo;
    }

    MaintenanceNotification* get_(MaintenanceNotificationId id) {
        return repo.findById(id);
    }

    MaintenanceNotification[] list() {
        return repo.findAll();
    }

    MaintenanceNotification[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    MaintenanceNotification[] listByStatus(NotificationStatus status) {
        return repo.findByStatus(status);
    }

    MaintenanceNotification[] listByEquipment(EquipmentId equipmentId) {
        return repo.findByEquipment(equipmentId);
    }

    MaintenanceNotification[] listByType(NotificationType notificationType) {
        return repo.findByType(notificationType);
    }

    CommandResult create(MaintenanceNotificationDTO dto) {
        MaintenanceNotification n;
        n.id = dto.id;
        n.tenantId = dto.tenantId;
        n.name = dto.name;
        n.description = dto.description;
        n.notificationNumber = dto.notificationNumber;
        n.equipmentId = dto.equipmentId;
        n.functionalLocationId = dto.functionalLocationId;
        n.breakdownIndicator = dto.breakdownIndicator;
        n.reportedBy = dto.reportedBy;
        n.reportedDate = dto.reportedDate;
        n.requiredStartDate = dto.requiredStartDate;
        n.requiredEndDate = dto.requiredEndDate;
        n.createdBy = dto.createdBy;
        if (!MaintenanceValidator.isValidMaintenanceNotification(n))
            return CommandResult(false, "", "Invalid notification data");
        repo.save(n);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MaintenanceNotificationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Notification not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.requiredStartDate.length > 0) existing.requiredStartDate = dto.requiredStartDate;
        if (dto.requiredEndDate.length > 0) existing.requiredEndDate = dto.requiredEndDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MaintenanceNotificationId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Notification not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
