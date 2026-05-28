/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.presentation.http.json_utils;

import uim.platform.itil;
import vibe.data.json;
import std.conv : to;

@safe:

Json itServiceToJson(ITService s) {
    auto j = Json.emptyObject;
    j["id"]           = s.id;
    j["tenantId"]     = s.tenantId;
    j["name"]         = s.name;
    j["description"]  = s.description;
    j["status"]       = s.status.to!string;
    j["serviceOwner"] = s.serviceOwner;
    j["serviceManager"] = s.serviceManager;
    j["supportTeam"]  = s.supportTeam;
    j["serviceLevel"] = s.serviceLevel;
    j["category"]     = s.category;
    j["createdBy"]    = s.createdBy;
    j["modifiedBy"]   = s.modifiedBy;
    return j;
}

Json serviceRequestToJson(ServiceRequest r) {
    auto j = Json.emptyObject;
    j["id"]              = r.id;
    j["tenantId"]        = r.tenantId;
    j["title"]           = r.title;
    j["description"]     = r.description;
    j["status"]          = r.status.to!string;
    j["priority"]        = r.priority.to!string;
    j["requesterId"]     = r.requesterId;
    j["requestDate"]     = r.requestDate;
    j["requiredByDate"]  = r.requiredByDate;
    j["resolvedDate"]    = r.resolvedDate;
    j["resolverId"]      = r.resolverId;
    j["assignedTo"]      = r.assignedTo;
    j["serviceId"]       = r.serviceId;
    j["category"]        = r.category;
    j["resolutionNotes"] = r.resolutionNotes;
    j["createdBy"]       = r.createdBy;
    j["modifiedBy"]      = r.modifiedBy;
    return j;
}

Json incidentToJson(Incident i) {
    auto j = Json.emptyObject;
    j["id"]               = i.id;
    j["tenantId"]         = i.tenantId;
    j["title"]            = i.title;
    j["description"]      = i.description;
    j["status"]           = i.status.to!string;
    j["priority"]         = i.priority.to!string;
    j["category"]         = i.category.to!string;
    j["reportedById"]     = i.reportedById;
    j["assignedTo"]       = i.assignedTo;
    j["assignedTeam"]     = i.assignedTeam;
    j["affectedServiceId"] = i.affectedServiceId;
    j["affectedCIId"]     = i.affectedCIId;
    j["linkedProblemId"]  = i.linkedProblemId;
    j["reportedAt"]       = i.reportedAt;
    j["resolutionNotes"]  = i.resolutionNotes;
    j["createdBy"]        = i.createdBy;
    j["modifiedBy"]       = i.modifiedBy;
    return j;
}

Json problemToJson(Problem p) {
    auto j = Json.emptyObject;
    j["id"]               = p.id;
    j["tenantId"]         = p.tenantId;
    j["title"]            = p.title;
    j["description"]      = p.description;
    j["problemStatus"]    = p.problemStatus.to!string;
    j["priority"]         = p.priority.to!string;
    j["category"]         = p.category;
    j["rootCause"]        = p.rootCause;
    j["workaround"]       = p.workaround;
    j["solution"]         = p.solution;
    j["affectedServiceId"] = p.affectedServiceId;
    j["assignedTo"]       = p.assignedTo;
    j["assignedTeam"]     = p.assignedTeam;
    j["createdBy"]        = p.createdBy;
    j["modifiedBy"]       = p.modifiedBy;
    return j;
}

Json changeRecordToJson(ChangeRecord c) {
    auto j = Json.emptyObject;
    j["id"]                  = c.id;
    j["tenantId"]            = c.tenantId;
    j["title"]               = c.title;
    j["description"]         = c.description;
    j["changeType"]          = c.changeType.to!string;
    j["changeStatus"]        = c.changeStatus.to!string;
    j["risk"]                = c.risk.to!string;
    j["priority"]            = c.priority.to!string;
    j["requestedBy"]         = c.requestedBy;
    j["assignedTo"]          = c.assignedTo;
    j["scheduledStartDate"]  = c.scheduledStartDate;
    j["scheduledEndDate"]    = c.scheduledEndDate;
    j["implementationNotes"] = c.implementationNotes;
    j["backoutPlan"]         = c.backoutPlan;
    j["createdBy"]           = c.createdBy;
    j["modifiedBy"]          = c.modifiedBy;
    return j;
}

Json configurationItemToJson(ConfigurationItem ci) {
    auto j = Json.emptyObject;
    j["id"]           = ci.id;
    j["tenantId"]     = ci.tenantId;
    j["name"]         = ci.name;
    j["description"]  = ci.description;
    j["ciType"]       = ci.ciType.to!string;
    j["ciStatus"]     = ci.ciStatus.to!string;
    j["version_"]     = ci.version_;
    j["manufacturer"] = ci.manufacturer;
    j["model"]        = ci.model;
    j["serialNumber"] = ci.serialNumber;
    j["ipAddress"]    = ci.ipAddress;
    j["location"]     = ci.location;
    j["ownerId"]      = ci.ownerId;
    j["supportTeam"]  = ci.supportTeam;
    j["installedDate"] = ci.installedDate;
    j["createdBy"]    = ci.createdBy;
    j["modifiedBy"]   = ci.modifiedBy;
    return j;
}

Json slaToJson(ServiceLevelAgreement s) {
    auto j = Json.emptyObject;
    j["id"]                  = s.id;
    j["tenantId"]            = s.tenantId;
    j["name"]                = s.name;
    j["description"]         = s.description;
    j["slaStatus"]           = s.slaStatus.to!string;
    j["serviceId"]           = s.serviceId;
    j["customerId"]          = s.customerId;
    j["startDate"]           = s.startDate;
    j["endDate"]             = s.endDate;
    j["availabilityTarget"]  = s.availabilityTarget;
    j["mttrTarget"]          = s.mttrTarget;
    j["responseTimeTarget"]  = s.responseTimeTarget;
    j["resolutionTimeTarget"] = s.resolutionTimeTarget;
    j["reviewCycle"]         = s.reviewCycle;
    j["accountManager"]      = s.accountManager;
    j["createdBy"]           = s.createdBy;
    j["modifiedBy"]          = s.modifiedBy;
    return j;
}

Json knowledgeArticleToJson(KnowledgeArticle k) {
    auto j = Json.emptyObject;
    j["id"]              = k.id;
    j["tenantId"]        = k.tenantId;
    j["title"]           = k.title;
    j["body_"]           = k.body_;
    j["knowledgeStatus"] = k.knowledgeStatus.to!string;
    j["category"]        = k.category;
    j["serviceId"]       = k.serviceId;
    j["author"]          = k.author;
    j["reviewer"]        = k.reviewer;
    j["publishedDate"]   = k.publishedDate;
    j["createdBy"]       = k.createdBy;
    j["modifiedBy"]      = k.modifiedBy;
    return j;
}

Json releaseRecordToJson(ReleaseRecord r) {
    auto j = Json.emptyObject;
    j["id"]              = r.id;
    j["tenantId"]        = r.tenantId;
    j["name"]            = r.name;
    j["description"]     = r.description;
    j["releaseType"]     = r.releaseType.to!string;
    j["releaseStatus"]   = r.releaseStatus.to!string;
    j["version_"]        = r.version_;
    j["targetDate"]      = r.targetDate;
    j["actualDate"]      = r.actualDate;
    j["deployedBy"]      = r.deployedBy;
    j["testPlan"]        = r.testPlan;
    j["deploymentPlan"]  = r.deploymentPlan;
    j["backoutPlan"]     = r.backoutPlan;
    j["createdBy"]       = r.createdBy;
    j["modifiedBy"]      = r.modifiedBy;
    return j;
}

Json monitoringEventToJson(MonitoringEvent e) {
    auto j = Json.emptyObject;
    j["id"]               = e.id;
    j["tenantId"]         = e.tenantId;
    j["title"]            = e.title;
    j["description"]      = e.description;
    j["severity"]         = e.severity.to!string;
    j["eventStatus"]      = e.eventStatus.to!string;
    j["sourceCI"]         = e.sourceCI;
    j["affectedServiceId"] = e.affectedServiceId;
    j["detectedAt"]       = e.detectedAt;
    j["acknowledgedBy"]   = e.acknowledgedBy;
    j["linkedIncidentId"] = e.linkedIncidentId;
    j["eventCode"]        = e.eventCode;
    j["eventSource"]      = e.eventSource;
    j["createdBy"]        = e.createdBy;
    j["modifiedBy"]       = e.modifiedBy;
    return j;
}

Json improvementItemToJson(ImprovementItem i) {
    auto j = Json.emptyObject;
    j["id"]                 = i.id;
    j["tenantId"]           = i.tenantId;
    j["title"]              = i.title;
    j["description"]        = i.description;
    j["improvementStatus"]  = i.improvementStatus.to!string;
    j["priority"]           = i.priority.to!string;
    j["category"]           = i.category;
    j["proposedBy"]         = i.proposedBy;
    j["owner"]              = i.owner;
    j["targetDate"]         = i.targetDate;
    j["expectedBenefit"]    = i.expectedBenefit;
    j["relatedServiceId"]   = i.relatedServiceId;
    j["createdBy"]          = i.createdBy;
    j["modifiedBy"]         = i.modifiedBy;
    return j;
}

Json itAssetToJson(ITAsset a) {
    auto j = Json.emptyObject;
    j["id"]            = a.id;
    j["tenantId"]      = a.tenantId;
    j["name"]          = a.name;
    j["description"]   = a.description;
    j["assetStatus"]   = a.assetStatus.to!string;
    j["assetType"]     = a.assetType.to!string;
    j["serialNumber"]  = a.serialNumber;
    j["manufacturer"]  = a.manufacturer;
    j["model"]         = a.model;
    j["purchaseDate"]  = a.purchaseDate;
    j["warrantyExpiry"] = a.warrantyExpiry;
    j["annualCostUsd"] = a.annualCostUsd;
    j["location"]      = a.location;
    j["assignedTo"]    = a.assignedTo;
    j["linkedCIId"]    = a.linkedCIId;
    j["createdBy"]     = a.createdBy;
    j["modifiedBy"]    = a.modifiedBy;
    return j;
}
