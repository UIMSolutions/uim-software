module uim.platform.apm.presentation.http.json_utils;

import std.conv : to;
import uim.platform.apm;
import vibe.http.server : HTTPServerResponse;

@safe:

void writeJsonBody(scope HTTPServerResponse res, Json body, int status = 200) {
    res.writeJsonBody(body, status);
}

Json portfolioItemToJson(ApplicationPortfolioItem item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["name"] = Json(item.name);
    j["description"] = Json(item.description);
    j["businessCapability"] = Json(item.businessCapability);
    j["organization"] = Json(item.organization);
    j["lifecyclePhase"] = Json(to!string(item.lifecyclePhase));
    j["businessCriticality"] = Json(to!string(item.businessCriticality));
    j["annualCostUsd"] = Json(item.annualCostUsd);
    j["owner"] = Json(item.owner);
    j["createdBy"] = Json(item.createdBy);
    j["modifiedBy"] = Json(item.modifiedBy);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json assessmentToJson(ApplicationAssessment assessment) {
    auto j = Json.emptyObject;
    j["id"] = Json(assessment.id);
    j["tenantId"] = Json(assessment.tenantId);
    j["applicationId"] = Json(assessment.applicationId);
    j["assessmentDate"] = Json(assessment.assessmentDate);
    j["assessor"] = Json(assessment.assessor);
    j["functionalFit"] = Json(to!string(assessment.functionalFit));
    j["technicalFit"] = Json(to!string(assessment.technicalFit));
    j["businessValue"] = Json(to!string(assessment.businessValue));
    j["dataQuality"] = Json(to!string(assessment.dataQuality));
    j["overallScore"] = Json(assessment.overallScore);
    j["recommendation"] = Json(to!string(assessment.recommendation));
    j["riskNotes"] = Json(assessment.riskNotes);
    j["nextReviewDate"] = Json(assessment.nextReviewDate);
    j["createdBy"] = Json(assessment.createdBy);
    j["modifiedBy"] = Json(assessment.modifiedBy);
    j["createdAt"] = Json(assessment.createdAt);
    j["modifiedAt"] = Json(assessment.modifiedAt);
    return j;
}

Json matrixPointToJson(PortfolioMatrixPoint point) {
    auto j = Json.emptyObject;
    j["applicationId"] = Json(point.applicationId);
    j["applicationName"] = Json(point.applicationName);
    j["organization"] = Json(point.organization);
    j["businessCapability"] = Json(point.businessCapability);
    j["businessCriticality"] = Json(point.businessCriticality);
    j["functionalFit"] = Json(point.functionalFit);
    j["technicalFit"] = Json(point.technicalFit);
    j["overallScore"] = Json(point.overallScore);
    j["recommendation"] = Json(point.recommendation);
    return j;
}

Json summaryToJson(PortfolioSummaryDTO summary) {
    auto j = Json.emptyObject;
    j["totalApplications"] = Json(summary.totalApplications);
    j["totalAssessments"] = Json(summary.totalAssessments);
    j["assessedApplications"] = Json(summary.assessedApplications);
    j["averageScore"] = Json(summary.averageScore);
    j["investCount"] = Json(summary.investCount);
    j["tolerateCount"] = Json(summary.tolerateCount);
    j["migrateCount"] = Json(summary.migrateCount);
    j["eliminateCount"] = Json(summary.eliminateCount);
    return j;
}
