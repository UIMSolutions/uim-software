/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.application.dto;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct SecurityEventDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string source;
    string severity;
    string status;
    string sourceIp;
    string destinationIp;
    string sourcePort;
    string destinationPort;
    string protocol;
    string username;
    string hostname;
    string rawLog;
    string eventType;
    string category;
    string action;
    string outcome;
    string assetId;
    string correlationRuleId;
    string alertId;
    string timestamp;
    string receivedAt;
    string createdBy;
    string modifiedBy;
}

struct AlertDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string severity;
    string status;
    string correlationRuleId;
    string ruleName;
    string sourceEventIds;
    string affectedAssetId;
    string sourceIp;
    string destinationIp;
    string username;
    string mitreTactic;
    string mitreTechnique;
    string assignedTo;
    string resolvedBy;
    string resolutionNote;
    string firstSeenAt;
    string lastSeenAt;
    string createdBy;
    string modifiedBy;
}

struct IncidentDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string severity;
    string status;
    string alertIds;
    string affectedAssetIds;
    string leadAnalyst;
    string respondents;
    string attackVector;
    string mitreTactics;
    string mitreTechniques;
    string containmentActions;
    string eradicationActions;
    string recoveryActions;
    string lessonsLearned;
    string detectedAt;
    string containedAt;
    string createdBy;
    string modifiedBy;
}

struct CorrelationRuleDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string ruleType;
    string status;
    string ruleExpression;
    string conditionField;
    string conditionOperator;
    string conditionValue;
    string timeWindowSeconds;
    string threshold;
    string aggregationField;
    string severity;
    string alertName;
    string mitreTactic;
    string mitreTechnique;
    string author;
    string version_;
    string tags;
    string createdBy;
    string modifiedBy;
}

struct AssetDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string assetType;
    string criticality;
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
}

struct ThreatIndicatorDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string indicatorType;
    string confidence;
    string value;
    string threatActor;
    string malwareFamily;
    string campaign;
    string tlpLevel;
    string source;
    string tags;
    string expiresAt;
    string firstSeenAt;
    string lastSeenAt;
    string createdBy;
    string modifiedBy;
}
