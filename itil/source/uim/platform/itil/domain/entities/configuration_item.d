/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.configuration_item;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ConfigurationItem {
    ConfigurationItemId id;
    TenantId tenantId;
    string name;
    string description;
    CIType ciType = CIType.hardware;
    CIStatus ciStatus = CIStatus.active;
    string version_;
    string manufacturer;
    string model;
    string serialNumber;
    string ipAddress;
    string location;
    string ownerId;
    string supportTeam;
    string installedDate;
    string retirementDate;
    string[] relatedCIIds;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
