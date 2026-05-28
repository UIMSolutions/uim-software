/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.entities.it_component;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct ITComponent {
    ITComponentId id;
    TenantId tenantId;
    string name;
    string description;
    FactSheetStatus status = FactSheetStatus.active;
    ITComponentType componentType = ITComponentType.software;
    ITComponentLifecycleStatus lifecycleStatus = ITComponentLifecycleStatus.active;
    TechCategoryId techCategoryId;
    ProviderId providerId;
    string version_;
    string releaseDate;
    string endOfLifeDate;
    string licenseModel;
    string annualCostUsd;
    RiskLevel technicalRisk = RiskLevel.low;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
