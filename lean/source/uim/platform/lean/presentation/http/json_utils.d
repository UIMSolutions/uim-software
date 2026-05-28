/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.presentation.http.json_utils;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

Json objectiveToJson(ref Objective o) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(o.id);
    j["tenantId"] = Json(o.tenantId);
    j["name"] = Json(o.name);
    j["description"] = Json(o.description);
    j["status"] = Json(o.status.to!string);
    j["objectiveType"] = Json(o.objectiveType.to!string);
    j["targetDate"] = Json(o.targetDate);
    j["owner"] = Json(o.owner);
    j["owningOrgId"] = Json(o.owningOrgId);
    j["createdBy"] = Json(o.createdBy);
    j["modifiedBy"] = Json(o.modifiedBy);
    j["createdAt"] = Json(o.createdAt);
    j["modifiedAt"] = Json(o.modifiedAt);
    return j;
}

Json leanPlatformToJson(ref LeanPlatform p) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(p.id);
    j["tenantId"] = Json(p.tenantId);
    j["name"] = Json(p.name);
    j["description"] = Json(p.description);
    j["status"] = Json(p.status.to!string);
    j["owner"] = Json(p.owner);
    j["owningOrgId"] = Json(p.owningOrgId);
    j["createdBy"] = Json(p.createdBy);
    j["modifiedBy"] = Json(p.modifiedBy);
    j["createdAt"] = Json(p.createdAt);
    j["modifiedAt"] = Json(p.modifiedAt);
    return j;
}

Json initiativeToJson(ref Initiative i) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(i.id);
    j["tenantId"] = Json(i.tenantId);
    j["name"] = Json(i.name);
    j["description"] = Json(i.description);
    j["status"] = Json(i.status.to!string);
    j["initiativeStatus"] = Json(i.initiativeStatus.to!string);
    j["phase"] = Json(i.phase.to!string);
    j["budgetUsd"] = Json(i.budgetUsd);
    j["startDate"] = Json(i.startDate);
    j["endDate"] = Json(i.endDate);
    j["responsiblePerson"] = Json(i.responsiblePerson);
    j["responsibleOrgId"] = Json(i.responsibleOrgId);
    j["createdBy"] = Json(i.createdBy);
    j["modifiedBy"] = Json(i.modifiedBy);
    j["createdAt"] = Json(i.createdAt);
    j["modifiedAt"] = Json(i.modifiedAt);
    return j;
}

Json organizationToJson(ref Organization o) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(o.id);
    j["tenantId"] = Json(o.tenantId);
    j["name"] = Json(o.name);
    j["description"] = Json(o.description);
    j["status"] = Json(o.status.to!string);
    j["parentOrgId"] = Json(o.parentOrgId);
    j["level"] = Json(cast(long) o.level);
    j["orgCode"] = Json(o.orgCode);
    j["costCenter"] = Json(o.costCenter);
    j["headCount"] = Json(o.headCount);
    j["location"] = Json(o.location);
    j["orgHead"] = Json(o.orgHead);
    j["createdBy"] = Json(o.createdBy);
    j["modifiedBy"] = Json(o.modifiedBy);
    j["createdAt"] = Json(o.createdAt);
    j["modifiedAt"] = Json(o.modifiedAt);
    return j;
}

Json businessCapabilityToJson(ref BusinessCapability bc) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(bc.id);
    j["tenantId"] = Json(bc.tenantId);
    j["name"] = Json(bc.name);
    j["description"] = Json(bc.description);
    j["status"] = Json(bc.status.to!string);
    j["parentCapabilityId"] = Json(bc.parentCapabilityId);
    j["level"] = Json(cast(long) bc.level);
    j["maturityLevel"] = Json(bc.maturityLevel.to!string);
    j["owningOrgId"] = Json(bc.owningOrgId);
    j["createdBy"] = Json(bc.createdBy);
    j["modifiedBy"] = Json(bc.modifiedBy);
    j["createdAt"] = Json(bc.createdAt);
    j["modifiedAt"] = Json(bc.modifiedAt);
    return j;
}

Json businessContextToJson(ref BusinessContext bc) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(bc.id);
    j["tenantId"] = Json(bc.tenantId);
    j["name"] = Json(bc.name);
    j["description"] = Json(bc.description);
    j["status"] = Json(bc.status.to!string);
    j["capabilityId"] = Json(bc.capabilityId);
    j["owningOrgId"] = Json(bc.owningOrgId);
    j["processOwner"] = Json(bc.processOwner);
    j["frequency"] = Json(bc.frequency);
    j["createdBy"] = Json(bc.createdBy);
    j["modifiedBy"] = Json(bc.modifiedBy);
    j["createdAt"] = Json(bc.createdAt);
    j["modifiedAt"] = Json(bc.modifiedAt);
    return j;
}

Json dataObjectToJson(ref DataObject d) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(d.id);
    j["tenantId"] = Json(d.tenantId);
    j["name"] = Json(d.name);
    j["description"] = Json(d.description);
    j["status"] = Json(d.status.to!string);
    j["classification"] = Json(d.classification.to!string);
    j["owningApplicationId"] = Json(d.owningApplicationId);
    j["dataFormat"] = Json(d.dataFormat);
    j["retentionPeriodDays"] = Json(d.retentionPeriodDays);
    j["personalDataFlag"] = Json(d.personalDataFlag);
    j["gdprBasis"] = Json(d.gdprBasis);
    j["createdBy"] = Json(d.createdBy);
    j["modifiedBy"] = Json(d.modifiedBy);
    j["createdAt"] = Json(d.createdAt);
    j["modifiedAt"] = Json(d.modifiedAt);
    return j;
}

Json leanApplicationToJson(ref LeanApplication a) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(a.id);
    j["tenantId"] = Json(a.tenantId);
    j["name"] = Json(a.name);
    j["description"] = Json(a.description);
    j["status"] = Json(a.status.to!string);
    j["applicationType"] = Json(a.applicationType.to!string);
    j["lifecycleStatus"] = Json(a.lifecycleStatus.to!string);
    j["functionalFit"] = Json(a.functionalFit.to!string);
    j["technicalFit"] = Json(a.technicalFit.to!string);
    j["owningOrgId"] = Json(a.owningOrgId);
    j["itOwner"] = Json(a.itOwner);
    j["businessOwner"] = Json(a.businessOwner);
    j["vendor"] = Json(a.vendor);
    j["version"] = Json(a.version_);
    j["deploymentDate"] = Json(a.deploymentDate);
    j["retirementDate"] = Json(a.retirementDate);
    j["annualCostUsd"] = Json(a.annualCostUsd);
    j["createdBy"] = Json(a.createdBy);
    j["modifiedBy"] = Json(a.modifiedBy);
    j["createdAt"] = Json(a.createdAt);
    j["modifiedAt"] = Json(a.modifiedAt);
    return j;
}

Json appInterfaceToJson(ref AppInterface ai) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(ai.id);
    j["tenantId"] = Json(ai.tenantId);
    j["name"] = Json(ai.name);
    j["description"] = Json(ai.description);
    j["status"] = Json(ai.status.to!string);
    j["sourceApplicationId"] = Json(ai.sourceApplicationId);
    j["targetApplicationId"] = Json(ai.targetApplicationId);
    j["direction"] = Json(ai.direction.to!string);
    j["frequency"] = Json(ai.frequency.to!string);
    j["protocol"] = Json(ai.protocol);
    j["dataFormat"] = Json(ai.dataFormat);
    j["dataObjectId"] = Json(ai.dataObjectId);
    j["createdBy"] = Json(ai.createdBy);
    j["modifiedBy"] = Json(ai.modifiedBy);
    j["createdAt"] = Json(ai.createdAt);
    j["modifiedAt"] = Json(ai.modifiedAt);
    return j;
}

Json providerToJson(ref Provider p) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(p.id);
    j["tenantId"] = Json(p.tenantId);
    j["name"] = Json(p.name);
    j["description"] = Json(p.description);
    j["status"] = Json(p.status.to!string);
    j["website"] = Json(p.website);
    j["contactEmail"] = Json(p.contactEmail);
    j["contractNumber"] = Json(p.contractNumber);
    j["contractStartDate"] = Json(p.contractStartDate);
    j["contractEndDate"] = Json(p.contractEndDate);
    j["annualCostUsd"] = Json(p.annualCostUsd);
    j["country"] = Json(p.country);
    j["createdBy"] = Json(p.createdBy);
    j["modifiedBy"] = Json(p.modifiedBy);
    j["createdAt"] = Json(p.createdAt);
    j["modifiedAt"] = Json(p.modifiedAt);
    return j;
}

Json itComponentToJson(ref ITComponent c) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(c.id);
    j["tenantId"] = Json(c.tenantId);
    j["name"] = Json(c.name);
    j["description"] = Json(c.description);
    j["status"] = Json(c.status.to!string);
    j["componentType"] = Json(c.componentType.to!string);
    j["lifecycleStatus"] = Json(c.lifecycleStatus.to!string);
    j["techCategoryId"] = Json(c.techCategoryId);
    j["providerId"] = Json(c.providerId);
    j["version"] = Json(c.version_);
    j["releaseDate"] = Json(c.releaseDate);
    j["endOfLifeDate"] = Json(c.endOfLifeDate);
    j["licenseModel"] = Json(c.licenseModel);
    j["annualCostUsd"] = Json(c.annualCostUsd);
    j["technicalRisk"] = Json(c.technicalRisk.to!string);
    j["createdBy"] = Json(c.createdBy);
    j["modifiedBy"] = Json(c.modifiedBy);
    j["createdAt"] = Json(c.createdAt);
    j["modifiedAt"] = Json(c.modifiedAt);
    return j;
}

Json techCategoryToJson(ref TechCategory tc) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(tc.id);
    j["tenantId"] = Json(tc.tenantId);
    j["name"] = Json(tc.name);
    j["description"] = Json(tc.description);
    j["status"] = Json(tc.status.to!string);
    j["parentCategoryId"] = Json(tc.parentCategoryId);
    j["level"] = Json(cast(long) tc.level);
    j["createdBy"] = Json(tc.createdBy);
    j["modifiedBy"] = Json(tc.modifiedBy);
    j["createdAt"] = Json(tc.createdAt);
    j["modifiedAt"] = Json(tc.modifiedAt);
    return j;
}
