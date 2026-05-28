/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.presentation.http.json_utils;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

Json securityEventToJson(ref SecurityEvent e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["source"] = Json(e.source.to!string);
    j["severity"] = Json(e.severity.to!string);
    j["status"] = Json(e.status.to!string);
    j["sourceIp"] = Json(e.sourceIp);
    j["destinationIp"] = Json(e.destinationIp);
    j["sourcePort"] = Json(e.sourcePort);
    j["destinationPort"] = Json(e.destinationPort);
    j["protocol"] = Json(e.protocol);
    j["username"] = Json(e.username);
    j["hostname"] = Json(e.hostname);
    j["eventType"] = Json(e.eventType);
    j["category"] = Json(e.category);
    j["action"] = Json(e.action);
    j["outcome"] = Json(e.outcome);
    j["assetId"] = Json(e.assetId);
    j["correlationRuleId"] = Json(e.correlationRuleId);
    j["alertId"] = Json(e.alertId);
    j["timestamp"] = Json(e.timestamp);
    j["receivedAt"] = Json(e.receivedAt);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json alertToJson(ref Alert a) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(a.id);
    j["tenantId"] = Json(a.tenantId);
    j["name"] = Json(a.name);
    j["description"] = Json(a.description);
    j["severity"] = Json(a.severity.to!string);
    j["status"] = Json(a.status.to!string);
    j["correlationRuleId"] = Json(a.correlationRuleId);
    j["ruleName"] = Json(a.ruleName);
    j["sourceEventIds"] = Json(a.sourceEventIds);
    j["affectedAssetId"] = Json(a.affectedAssetId);
    j["sourceIp"] = Json(a.sourceIp);
    j["destinationIp"] = Json(a.destinationIp);
    j["username"] = Json(a.username);
    j["mitreTactic"] = Json(a.mitreTactic);
    j["mitreTechnique"] = Json(a.mitreTechnique);
    j["assignedTo"] = Json(a.assignedTo);
    j["resolvedBy"] = Json(a.resolvedBy);
    j["resolutionNote"] = Json(a.resolutionNote);
    j["firstSeenAt"] = Json(a.firstSeenAt);
    j["lastSeenAt"] = Json(a.lastSeenAt);
    j["resolvedAt"] = Json(a.resolvedAt);
    j["createdBy"] = Json(a.createdBy);
    j["modifiedBy"] = Json(a.modifiedBy);
    j["createdAt"] = Json(a.createdAt);
    j["modifiedAt"] = Json(a.modifiedAt);
    return j;
}

Json incidentToJson(ref Incident i) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(i.id);
    j["tenantId"] = Json(i.tenantId);
    j["name"] = Json(i.name);
    j["description"] = Json(i.description);
    j["severity"] = Json(i.severity.to!string);
    j["status"] = Json(i.status.to!string);
    j["alertIds"] = Json(i.alertIds);
    j["affectedAssetIds"] = Json(i.affectedAssetIds);
    j["leadAnalyst"] = Json(i.leadAnalyst);
    j["respondents"] = Json(i.respondents);
    j["attackVector"] = Json(i.attackVector);
    j["mitreTactics"] = Json(i.mitreTactics);
    j["mitreTechniques"] = Json(i.mitreTechniques);
    j["containmentActions"] = Json(i.containmentActions);
    j["eradicationActions"] = Json(i.eradicationActions);
    j["recoveryActions"] = Json(i.recoveryActions);
    j["lessonsLearned"] = Json(i.lessonsLearned);
    j["detectedAt"] = Json(i.detectedAt);
    j["containedAt"] = Json(i.containedAt);
    j["resolvedAt"] = Json(i.resolvedAt);
    j["createdBy"] = Json(i.createdBy);
    j["modifiedBy"] = Json(i.modifiedBy);
    j["createdAt"] = Json(i.createdAt);
    j["modifiedAt"] = Json(i.modifiedAt);
    return j;
}

Json correlationRuleToJson(ref CorrelationRule r) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(r.id);
    j["tenantId"] = Json(r.tenantId);
    j["name"] = Json(r.name);
    j["description"] = Json(r.description);
    j["ruleType"] = Json(r.ruleType.to!string);
    j["status"] = Json(r.status.to!string);
    j["ruleExpression"] = Json(r.ruleExpression);
    j["conditionField"] = Json(r.conditionField);
    j["conditionOperator"] = Json(r.conditionOperator);
    j["conditionValue"] = Json(r.conditionValue);
    j["timeWindowSeconds"] = Json(r.timeWindowSeconds);
    j["threshold"] = Json(r.threshold);
    j["aggregationField"] = Json(r.aggregationField);
    j["severity"] = Json(r.severity);
    j["alertName"] = Json(r.alertName);
    j["mitreTactic"] = Json(r.mitreTactic);
    j["mitreTechnique"] = Json(r.mitreTechnique);
    j["author"] = Json(r.author);
    j["version"] = Json(r.version_);
    j["tags"] = Json(r.tags);
    j["createdBy"] = Json(r.createdBy);
    j["modifiedBy"] = Json(r.modifiedBy);
    j["createdAt"] = Json(r.createdAt);
    j["modifiedAt"] = Json(r.modifiedAt);
    return j;
}

Json assetToJson(ref Asset a) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(a.id);
    j["tenantId"] = Json(a.tenantId);
    j["name"] = Json(a.name);
    j["description"] = Json(a.description);
    j["assetType"] = Json(a.assetType.to!string);
    j["criticality"] = Json(a.criticality.to!string);
    j["ipAddress"] = Json(a.ipAddress);
    j["macAddress"] = Json(a.macAddress);
    j["hostname"] = Json(a.hostname);
    j["operatingSystem"] = Json(a.operatingSystem);
    j["osVersion"] = Json(a.osVersion);
    j["owner"] = Json(a.owner);
    j["department"] = Json(a.department);
    j["location"] = Json(a.location);
    j["tags"] = Json(a.tags);
    j["lastSeenAt"] = Json(a.lastSeenAt);
    j["firstRegisteredAt"] = Json(a.firstRegisteredAt);
    j["createdBy"] = Json(a.createdBy);
    j["modifiedBy"] = Json(a.modifiedBy);
    j["createdAt"] = Json(a.createdAt);
    j["modifiedAt"] = Json(a.modifiedAt);
    return j;
}

Json threatIndicatorToJson(ref ThreatIndicator t) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(t.id);
    j["tenantId"] = Json(t.tenantId);
    j["name"] = Json(t.name);
    j["description"] = Json(t.description);
    j["indicatorType"] = Json(t.indicatorType.to!string);
    j["confidence"] = Json(t.confidence.to!string);
    j["value"] = Json(t.value);
    j["threatActor"] = Json(t.threatActor);
    j["malwareFamily"] = Json(t.malwareFamily);
    j["campaign"] = Json(t.campaign);
    j["tlpLevel"] = Json(t.tlpLevel);
    j["source"] = Json(t.source);
    j["tags"] = Json(t.tags);
    j["expiresAt"] = Json(t.expiresAt);
    j["firstSeenAt"] = Json(t.firstSeenAt);
    j["lastSeenAt"] = Json(t.lastSeenAt);
    j["createdBy"] = Json(t.createdBy);
    j["modifiedBy"] = Json(t.modifiedBy);
    j["createdAt"] = Json(t.createdAt);
    j["modifiedAt"] = Json(t.modifiedAt);
    return j;
}
