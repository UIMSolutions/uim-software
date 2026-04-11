/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.application.dto;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct EquipmentDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string equipmentNumber;
    string category;
    string status;
    string functionalLocationId;
    string manufacturer;
    string modelNumber;
    string serialNumber;
    string installationDate;
    string warrantyEndDate;
    string acquisitionValue;
    string currency;
    string createdBy;
    string modifiedBy;
}

struct FunctionalLocationDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string locationLabel;
    string locationType;
    string status;
    string parentLocationId;
    string plantSection;
    string costCenter;
    string address;
    string createdBy;
    string modifiedBy;
}

struct MaintenanceOrderDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string orderNumber;
    string orderType;
    string status;
    string priority;
    string equipmentId;
    string functionalLocationId;
    string workCenterId;
    string notificationId;
    string plannedStartDate;
    string plannedEndDate;
    string actualStartDate;
    string actualEndDate;
    string estimatedCost;
    string actualCost;
    string assignedTo;
    string createdBy;
    string modifiedBy;
}

struct MaintenanceNotificationDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string notificationNumber;
    string notificationType;
    string status;
    string priority;
    string equipmentId;
    string functionalLocationId;
    string breakdownIndicator;
    string reportedBy;
    string reportedDate;
    string requiredStartDate;
    string requiredEndDate;
    string createdBy;
    string modifiedBy;
}

struct MaintenancePlanDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string category;
    string status;
    string cycleLength;
    string cycleUnit;
    string leadTimeOffset;
    string schedulingPeriod;
    string lastScheduledDate;
    string nextDueDate;
    string createdBy;
    string modifiedBy;
}

struct WorkCenterDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string category;
    string plantSection;
    string costCenter;
    string capacity;
    string capacityUnit;
    string responsiblePerson;
    string createdBy;
    string modifiedBy;
}

struct MaterialBOMDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string equipmentId;
    string materialNumber;
    string materialDescription;
    string quantity;
    string unit;
    string storageLocation;
    string supplier;
    string unitPrice;
    string currency;
    string createdBy;
    string modifiedBy;
}

struct MaintenanceItemDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string maintenancePlanId;
    string equipmentId;
    string functionalLocationId;
    string taskListId;
    string taskListDescription;
    string workCenterId;
    string orderType;
    string cycle;
    string cycleUnit;
    string createdBy;
    string modifiedBy;
}
