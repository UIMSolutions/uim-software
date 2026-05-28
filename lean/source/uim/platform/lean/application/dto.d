/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.dto;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct ObjectiveDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string objectiveType;
    string targetDate;
    string owner;
    string owningOrgId;
    string createdBy;
    string modifiedBy;
}

struct LeanPlatformDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string owner;
    string owningOrgId;
    string createdBy;
    string modifiedBy;
}

struct InitiativeDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string initiativeStatus;
    string phase;
    string budgetUsd;
    string startDate;
    string endDate;
    string responsiblePerson;
    string responsibleOrgId;
    string createdBy;
    string modifiedBy;
}

struct OrganizationDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string parentOrgId;
    string orgCode;
    string costCenter;
    string headCount;
    string location;
    string orgHead;
    string createdBy;
    string modifiedBy;
}

struct BusinessCapabilityDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string parentCapabilityId;
    string maturityLevel;
    string owningOrgId;
    string createdBy;
    string modifiedBy;
}

struct BusinessContextDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string capabilityId;
    string owningOrgId;
    string processOwner;
    string frequency;
    string createdBy;
    string modifiedBy;
}

struct DataObjectDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string classification;
    string owningApplicationId;
    string dataFormat;
    string retentionPeriodDays;
    string personalDataFlag;
    string gdprBasis;
    string createdBy;
    string modifiedBy;
}

struct LeanApplicationDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string applicationType;
    string lifecycleStatus;
    string functionalFit;
    string technicalFit;
    string owningOrgId;
    string itOwner;
    string businessOwner;
    string vendor;
    string version_;
    string deploymentDate;
    string retirementDate;
    string annualCostUsd;
    string createdBy;
    string modifiedBy;
}

struct AppInterfaceDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string sourceApplicationId;
    string targetApplicationId;
    string direction;
    string frequency;
    string protocol;
    string dataFormat;
    string dataObjectId;
    string createdBy;
    string modifiedBy;
}

struct ProviderDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string website;
    string contactEmail;
    string contractNumber;
    string contractStartDate;
    string contractEndDate;
    string annualCostUsd;
    string country;
    string createdBy;
    string modifiedBy;
}

struct ITComponentDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string componentType;
    string lifecycleStatus;
    string techCategoryId;
    string providerId;
    string version_;
    string releaseDate;
    string endOfLifeDate;
    string licenseModel;
    string annualCostUsd;
    string technicalRisk;
    string createdBy;
    string modifiedBy;
}

struct TechCategoryDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string parentCategoryId;
    string createdBy;
    string modifiedBy;
}
