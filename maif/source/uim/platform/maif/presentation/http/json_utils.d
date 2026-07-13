module uim.platform.maif.presentation.http.json_utils;

import vibe.data.json : Json;
import uim.platform.maif.domain.entities.mobile_app : MobileApp;
import uim.platform.maif.domain.entities.integration_flow : IntegrationFlow;
import uim.platform.maif.domain.entities.sync_job : SyncJob;

@safe:

Json mobileAppToJson(MobileApp value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["platform"] = Json(value.platform);
    j["versionTag"] = Json(value.versionTag);
    j["status"] = Json(value.status);
    j["owner"] = Json(value.owner);
    j["backendSystem"] = Json(value.backendSystem);
    j["authProfile"] = Json(value.authProfile);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json integrationFlowToJson(IntegrationFlow value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["appId"] = Json(value.appId);
    j["name"] = Json(value.name);
    j["sourceSystem"] = Json(value.sourceSystem);
    j["targetSystem"] = Json(value.targetSystem);
    j["protocol"] = Json(value.protocol);
    j["mappingPolicy"] = Json(value.mappingPolicy);
    j["retryPolicy"] = Json(value.retryPolicy);
    j["status"] = Json(value.status);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json syncJobToJson(SyncJob value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["flowId"] = Json(value.flowId);
    j["triggerType"] = Json(value.triggerType);
    j["status"] = Json(value.status);
    j["startedAt"] = Json(value.startedAt);
    j["finishedAt"] = Json(value.finishedAt);
    j["recordsProcessed"] = Json(value.recordsProcessed);
    j["recordsFailed"] = Json(value.recordsFailed);
    j["lastError"] = Json(value.lastError);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}
