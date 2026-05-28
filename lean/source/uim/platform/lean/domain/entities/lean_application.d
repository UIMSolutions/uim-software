/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.entities.lean_application;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct LeanApplication {
    LeanApplicationId id;
    TenantId tenantId;
    string name;
    string description;
    FactSheetStatus status = FactSheetStatus.active;
    ApplicationType applicationType = ApplicationType.internal;
    ApplicationLifecycleStatus lifecycleStatus = ApplicationLifecycleStatus.active;
    ApplicationFunctionalFit functionalFit = ApplicationFunctionalFit.adequate;
    ApplicationTechnicalFit technicalFit = ApplicationTechnicalFit.adequate;
    OrganizationId owningOrgId;
    string itOwner;
    string businessOwner;
    string vendor;
    string version_;
    string deploymentDate;
    string retirementDate;
    string annualCostUsd;
    string[] businessCapabilityIds;
    string[] itComponentIds;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
