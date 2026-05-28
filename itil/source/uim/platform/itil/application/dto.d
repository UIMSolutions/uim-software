/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.dto;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ITServiceDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string serviceOwner;
    string serviceManager;
    string supportTeam;
    string serviceLevel;
    string category;
    string createdBy;
    string modifiedBy;
}

struct ServiceRequestDTO {
    string id;
    string tenantId;
    string title;
    string description;
    string status;
    string priority;
    string requesterId;
    string requestDate;
    string requiredByDate;
    string resolvedDate;
    string resolverId;
    string assignedTo;
    string serviceId;
    string category;
    string resolutionNotes;
    string createdBy;
    string modifiedBy;
}

struct IncidentDTO {
    string id;
    string tenantId;
    string title;
    string description;
    string status;
    string priority;
    string category;
    string reportedById;
    string assignedTo;
    string assignedTeam;
    string affectedServiceId;
    string affectedCIId;
    string linkedProblemId;
    string reportedAt;
    string resolutionNotes;
    string createdBy;
    string modifiedBy;
}

struct ProblemDTO {
    string id;
    string tenantId;
    string title;
    string description;
    string problemStatus;
    string priority;
    string category;
    string rootCause;
    string workaround;
    string solution;
    string affectedServiceId;
    string assignedTo;
    string assignedTeam;
    string createdBy;
    string modifiedBy;
}

struct ChangeRecordDTO {
    string id;
    string tenantId;
    string title;
    string description;
    string changeType;
    string changeStatus;
    string risk;
    string priority;
    string requestedBy;
    string assignedTo;
    string scheduledStartDate;
    string scheduledEndDate;
    string implementationNotes;
    string backoutPlan;
    string createdBy;
    string modifiedBy;
}

struct ConfigurationItemDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string ciType;
    string ciStatus;
    string version_;
    string manufacturer;
    string model;
    string serialNumber;
    string ipAddress;
    string location;
    string ownerId;
    string supportTeam;
    string installedDate;
    string createdBy;
    string modifiedBy;
}

struct ServiceLevelAgreementDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string slaStatus;
    string serviceId;
    string customerId;
    string startDate;
    string endDate;
    string availabilityTarget;
    string mttrTarget;
    string responseTimeTarget;
    string resolutionTimeTarget;
    string reviewCycle;
    string accountManager;
    string createdBy;
    string modifiedBy;
}

struct KnowledgeArticleDTO {
    string id;
    string tenantId;
    string title;
    string body_;
    string knowledgeStatus;
    string category;
    string serviceId;
    string author;
    string reviewer;
    string publishedDate;
    string createdBy;
    string modifiedBy;
}

struct ReleaseRecordDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string releaseType;
    string releaseStatus;
    string version_;
    string targetDate;
    string deployedBy;
    string testPlan;
    string deploymentPlan;
    string backoutPlan;
    string createdBy;
    string modifiedBy;
}

struct MonitoringEventDTO {
    string id;
    string tenantId;
    string title;
    string description;
    string severity;
    string eventStatus;
    string sourceCI;
    string affectedServiceId;
    string detectedAt;
    string eventCode;
    string eventSource;
    string createdBy;
    string modifiedBy;
}

struct ImprovementItemDTO {
    string id;
    string tenantId;
    string title;
    string description;
    string improvementStatus;
    string priority;
    string category;
    string proposedBy;
    string owner;
    string targetDate;
    string expectedBenefit;
    string relatedServiceId;
    string createdBy;
    string modifiedBy;
}

struct ITAssetDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string assetStatus;
    string assetType;
    string serialNumber;
    string manufacturer;
    string model;
    string purchaseDate;
    string warrantyExpiry;
    string annualCostUsd;
    string location;
    string assignedTo;
    string linkedCIId;
    string createdBy;
    string modifiedBy;
}
