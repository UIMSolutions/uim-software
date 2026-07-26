module uim.platform.alm.presentation.http.json_utils;

import std.conv : to;

import uim.platform.alm.application.dto;
import uim.platform.alm.domain;

@safe:

private Json stringArrayToJson(string[] values) {
    auto arr = Json.emptyArray;
    foreach (value; values)
        arr ~= Json(value);
    return arr;
}

Json solutionToJson(Solution item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["name"] = Json(item.name);
    j["description"] = Json(item.description);
    j["owner"] = Json(item.owner);
    j["businessCapability"] = Json(item.businessCapability);
    j["stage"] = Json(to!string(item.stage));
    j["riskLevel"] = Json(to!string(item.riskLevel));
    j["portfolioTag"] = Json(item.portfolioTag);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json projectToJson(Project item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["solutionId"] = Json(item.solutionId);
    j["name"] = Json(item.name);
    j["description"] = Json(item.description);
    j["status"] = Json(to!string(item.status));
    j["deliveryLead"] = Json(item.deliveryLead);
    j["targetGoLiveDate"] = Json(item.targetGoLiveDate);
    j["budgetHint"] = Json(item.budgetHint);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json taskToJson(Task item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["solutionId"] = Json(item.solutionId);
    j["projectId"] = Json(item.projectId);
    j["title"] = Json(item.title);
    j["description"] = Json(item.description);
    j["status"] = Json(to!string(item.status));
    j["assignee"] = Json(item.assignee);
    j["dueDate"] = Json(item.dueDate);
    j["dependencyTaskId"] = Json(item.dependencyTaskId);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json testPlanToJson(TestPlan item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["solutionId"] = Json(item.solutionId);
    j["name"] = Json(item.name);
    j["status"] = Json(to!string(item.status));
    j["owner"] = Json(item.owner);
    j["objective"] = Json(item.objective);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json testCaseToJson(TestCase item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["planId"] = Json(item.planId);
    j["name"] = Json(item.name);
    j["status"] = Json(to!string(item.status));
    j["automated"] = Json(item.automated);
    j["priority"] = Json(item.priority);
    j["requirementRef"] = Json(item.requirementRef);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json defectToJson(Defect item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["solutionId"] = Json(item.solutionId);
    j["testCaseId"] = Json(item.testCaseId);
    j["title"] = Json(item.title);
    j["severity"] = Json(to!string(item.severity));
    j["status"] = Json(to!string(item.status));
    j["rootCause"] = Json(item.rootCause);
    j["assignedTo"] = Json(item.assignedTo);
    j["foundInEnvironment"] = Json(item.foundInEnvironment);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json releaseToJson(Release item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["solutionId"] = Json(item.solutionId);
    j["releaseVersion"] = Json(item.releaseVersion);
    j["status"] = Json(to!string(item.status));
    j["releaseScope"] = Json(item.releaseScope);
    j["plannedGoLiveDate"] = Json(item.plannedGoLiveDate);
    j["actualGoLiveDate"] = Json(item.actualGoLiveDate);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json deploymentToJson(Deployment item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["releaseId"] = Json(item.releaseId);
    j["environmentId"] = Json(item.environmentId);
    j["status"] = Json(to!string(item.status));
    j["startedAt"] = Json(item.startedAt);
    j["finishedAt"] = Json(item.finishedAt);
    j["executedBy"] = Json(item.executedBy);
    j["logUrl"] = Json(item.logUrl);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json environmentToJson(Environment item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["solutionId"] = Json(item.solutionId);
    j["name"] = Json(item.name);
    j["environmentType"] = Json(to!string(item.environmentType));
    j["region"] = Json(item.region);
    j["purpose"] = Json(item.purpose);
    j["active"] = Json(item.active);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json alertToJson(Alert item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["solutionId"] = Json(item.solutionId);
    j["source"] = Json(item.source);
    j["severity"] = Json(to!string(item.severity));
    j["status"] = Json(to!string(item.status));
    j["summary"] = Json(item.summary);
    j["raisedAt"] = Json(item.raisedAt);
    j["acknowledgedBy"] = Json(item.acknowledgedBy);
    j["resolvedAt"] = Json(item.resolvedAt);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json summaryToJson(AlmSummaryDTO item) {
    auto j = Json.emptyObject;
    j["totalSolutions"] = Json(item.totalSolutions);
    j["totalProjects"] = Json(item.totalProjects);
    j["totalTasks"] = Json(item.totalTasks);
    j["openTasks"] = Json(item.openTasks);
    j["totalTestPlans"] = Json(item.totalTestPlans);
    j["totalTestCases"] = Json(item.totalTestCases);
    j["criticalDefects"] = Json(item.criticalDefects);
    j["totalReleases"] = Json(item.totalReleases);
    j["activeDeployments"] = Json(item.activeDeployments);
    j["openAlerts"] = Json(item.openAlerts);
    j["criticalAlerts"] = Json(item.criticalAlerts);
    j["readinessScore"] = Json(item.readinessScore);
    return j;
}
