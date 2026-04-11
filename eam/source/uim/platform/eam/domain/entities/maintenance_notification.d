/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.entities.maintenance_notification;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct MaintenanceNotification {
    MaintenanceNotificationId id;
    TenantId tenantId;
    string name;
    string description;
    string notificationNumber;
    NotificationType notificationType = NotificationType.malfunction;
    NotificationStatus status = NotificationStatus.outstanding;
    NotificationPriority priority = NotificationPriority.medium;
    EquipmentId equipmentId;
    FunctionalLocationId functionalLocationId;
    string breakdownIndicator;
    string reportedBy;
    string reportedDate;
    string requiredStartDate;
    string requiredEndDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
