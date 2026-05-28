/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.it_asset;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ITAsset {
    ITAssetId id;
    TenantId tenantId;
    string name;
    string description;
    AssetStatus assetStatus = AssetStatus.active;
    AssetType assetType = AssetType.hardware;
    string serialNumber;
    string manufacturer;
    string model;
    string purchaseDate;
    string warrantyExpiry;
    string annualCostUsd;
    string location;
    string assignedTo;
    ConfigurationItemId linkedCIId;
    string disposalDate;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
