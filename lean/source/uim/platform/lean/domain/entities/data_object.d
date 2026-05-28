/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.entities.data_object;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct DataObject {
    DataObjectId id;
    TenantId tenantId;
    string name;
    string description;
    FactSheetStatus status = FactSheetStatus.active;
    DataClassification classification = DataClassification.internal_;
    LeanApplicationId owningApplicationId;
    string dataFormat;
    string retentionPeriodDays;
    bool personalDataFlag;
    string gdprBasis;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
