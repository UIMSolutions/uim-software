/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.entities.asset;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct Asset {
    AssetId id;
    TenantId tenantId;
    string name;
    string description;
    AssetType assetType = AssetType.server;
    AssetCriticality criticality = AssetCriticality.medium;
    string ipAddress;
    string macAddress;
    string hostname;
    string operatingSystem;
    string osVersion;
    string owner;
    string department;
    string location;
    string tags;
    string lastSeenAt;
    string firstRegisteredAt;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
