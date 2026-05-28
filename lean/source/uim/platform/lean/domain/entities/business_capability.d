/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.entities.business_capability;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct BusinessCapability {
    BusinessCapabilityId id;
    TenantId tenantId;
    string name;
    string description;
    FactSheetStatus status = FactSheetStatus.active;
    BusinessCapabilityId parentCapabilityId;
    int level;
    MaturityLevel maturityLevel = MaturityLevel.initial;
    string[] supportingApplicationIds;
    OrganizationId owningOrgId;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
