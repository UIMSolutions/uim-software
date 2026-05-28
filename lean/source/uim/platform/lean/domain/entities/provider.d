/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.entities.provider;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct Provider {
    ProviderId id;
    TenantId tenantId;
    string name;
    string description;
    FactSheetStatus status = FactSheetStatus.active;
    string website;
    string contactEmail;
    string contractNumber;
    string contractStartDate;
    string contractEndDate;
    string annualCostUsd;
    string country;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
