/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.types;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

// --- ID Aliases ---
alias EquipmentId = string;
alias FunctionalLocationId = string;
alias MaintenanceOrderId = string;
alias MaintenanceNotificationId = string;
alias MaintenancePlanId = string;
alias WorkCenterId = string;
alias MaterialBOMId = string;
alias MaintenanceItemId = string;
alias TenantId = string;
alias UserId = string;

// --- Enumerations ---

enum EquipmentCategory {
    machine,
    vehicle,
    tool,
    instrument,
    electricalEquipment,
    productionResource,
    itAsset,
    building
}

enum EquipmentStatus {
    active,
    inactive,
    inMaintenance,
    decommissioned,
    reserved,
    inStorage
}

enum FunctionalLocationType {
    plant,
    building,
    floor,
    room,
    area,
    line,
    station,
    zone
}

enum FunctionalLocationStatus {
    active,
    inactive,
    underConstruction,
    decommissioned
}

enum OrderType {
    corrective,
    preventive,
    predictive,
    emergency,
    overhaul,
    inspection,
    calibration
}

enum OrderStatus {
    created,
    released,
    inProgress,
    completed,
    technicallyClosed,
    businessClosed,
    cancelled
}

enum OrderPriority {
    veryHigh,
    high,
    medium,
    low
}

enum NotificationType {
    malfunction,
    maintenanceRequest,
    activityReport,
    breakdown,
    safetyHazard
}

enum NotificationStatus {
    outstanding,
    inProcess,
    completed,
    postponed,
    cancelled
}

enum NotificationPriority {
    veryHigh,
    high,
    medium,
    low
}

enum PlanCategory {
    timeBased,
    performanceBased,
    conditionBased,
    multiCounter
}

enum PlanStatus {
    active,
    inactive,
    scheduled,
    completed,
    suspended
}

enum WorkCenterCategory {
    workshop,
    crew,
    laboratory,
    external,
    subcontractor
}

enum CycleUnit {
    hours,
    days,
    weeks,
    months,
    years,
    kilometers,
    operatingHours
}
