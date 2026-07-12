module uim.platform.etd.presentation.http.json_utils;

import vibe.data.json : Json;
import uim.platform.etd.domain.entities.detection_rule : DetectionRule;
import uim.platform.etd.domain.entities.incident : Incident;
import uim.platform.etd.domain.entities.threat_indicator : ThreatIndicator;

@safe:

Json incidentToJson(Incident value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["title"] = Json(value.title);
    j["description"] = Json(value.description);
    j["severity"] = Json(value.severity);
    j["status"] = Json(value.status);
    j["category"] = Json(value.category);
    j["sourceSystem"] = Json(value.sourceSystem);
    j["detectedAt"] = Json(value.detectedAt);
    j["assignedTo"] = Json(value.assignedTo);
    j["containmentStatus"] = Json(value.containmentStatus);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json threatIndicatorToJson(ThreatIndicator value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["indicatorType"] = Json(value.indicatorType);
    j["indicatorValue"] = Json(value.indicatorValue);
    j["confidence"] = Json(value.confidence);
    j["severity"] = Json(value.severity);
    j["firstSeenAt"] = Json(value.firstSeenAt);
    j["lastSeenAt"] = Json(value.lastSeenAt);
    j["source"] = Json(value.source);
    j["status"] = Json(value.status);
    j["enrichment"] = Json(value.enrichment);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json detectionRuleToJson(DetectionRule value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["queryPattern"] = Json(value.queryPattern);
    j["severity"] = Json(value.severity);
    j["schedule"] = Json(value.schedule);
    j["status"] = Json(value.status);
    j["mitreTactic"] = Json(value.mitreTactic);
    j["mitreTechnique"] = Json(value.mitreTechnique);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}
