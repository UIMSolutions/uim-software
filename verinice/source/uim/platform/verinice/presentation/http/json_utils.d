module uim.platform.verinice.presentation.http.json_utils;

import uim.platform.verinice;
import vibe.http.server : HTTPServerResponse;

@safe:

void writeJsonBody(scope HTTPServerResponse res, Json body, int status = 200) {
    res.writeJsonBody(body, status);
}

Json assetToJson(Asset value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["assetType"] = Json(value.assetType);
    j["confidentiality"] = Json(value.confidentiality);
    j["integrity"] = Json(value.integrity);
    j["availability"] = Json(value.availability);
    j["owner"] = Json(value.owner);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json safeguardToJson(Safeguard value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["assetId"] = Json(value.assetId);
    j["code"] = Json(value.code);
    j["title"] = Json(value.title);
    j["description"] = Json(value.description);
    j["implementationStatus"] = Json(value.implementationStatus);
    j["maturityLevel"] = Json(value.maturityLevel);
    j["owner"] = Json(value.owner);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json assessmentToJson(Assessment value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["assetId"] = Json(value.assetId);
    j["safeguardId"] = Json(value.safeguardId);
    j["status"] = Json(value.status);
    j["riskLevel"] = Json(value.riskLevel);
    j["justification"] = Json(value.justification);
    j["reviewer"] = Json(value.reviewer);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}
