module uim.platform.ppm.presentation.http.json_utils;

import uim.platform.ppm;
import vibe.http.server : HTTPServerResponse;

@safe:

void writeJsonBody(scope HTTPServerResponse res, Json body, int status = 200) {
    res.writeJsonBody(body, status);
}

Json portfolioToJson(Portfolio value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["strategicTheme"] = Json(value.strategicTheme);
    j["status"] = Json(value.status);
    j["planningHorizon"] = Json(value.planningHorizon);
    j["owner"] = Json(value.owner);
    j["budgetAmount"] = Json(value.budgetAmount);
    j["currency"] = Json(value.currency);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json initiativeToJson(Initiative value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["portfolioId"] = Json(value.portfolioId);
    j["title"] = Json(value.title);
    j["description"] = Json(value.description);
    j["category"] = Json(value.category);
    j["priority"] = Json(value.priority);
    j["status"] = Json(value.status);
    j["sponsor"] = Json(value.sponsor);
    j["expectedBenefits"] = Json(value.expectedBenefits);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json programToJson(Program value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["portfolioId"] = Json(value.portfolioId);
    j["name"] = Json(value.name);
    j["objective"] = Json(value.objective);
    j["status"] = Json(value.status);
    j["manager"] = Json(value.manager);
    j["startDate"] = Json(value.startDate);
    j["endDate"] = Json(value.endDate);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json projectToJson(Project value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["programId"] = Json(value.programId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["projectType"] = Json(value.projectType);
    j["status"] = Json(value.status);
    j["startDate"] = Json(value.startDate);
    j["endDate"] = Json(value.endDate);
    j["projectManager"] = Json(value.projectManager);
    j["budgetAmount"] = Json(value.budgetAmount);
    j["currency"] = Json(value.currency);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json demandToJson(Demand value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["portfolioId"] = Json(value.portfolioId);
    j["title"] = Json(value.title);
    j["description"] = Json(value.description);
    j["source"] = Json(value.source);
    j["businessValue"] = Json(value.businessValue);
    j["priority"] = Json(value.priority);
    j["status"] = Json(value.status);
    j["requestedBy"] = Json(value.requestedBy);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json resourceRequestToJson(ResourceRequest value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["projectId"] = Json(value.projectId);
    j["role"] = Json(value.role);
    j["quantity"] = Json(value.quantity);
    j["allocationPercent"] = Json(value.allocationPercent);
    j["startDate"] = Json(value.startDate);
    j["endDate"] = Json(value.endDate);
    j["status"] = Json(value.status);
    j["requestedBy"] = Json(value.requestedBy);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}
