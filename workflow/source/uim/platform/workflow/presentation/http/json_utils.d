module uim.platform.workflow.presentation.http.json_utils;

import std.conv : to;

import uim.platform.workflow;
import uim.platform.workflow.domain.entities.workflow_entities;

@safe:

Json workflowDefinitionToJson(ref WorkflowDefinition value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["name"] = Json(value.name);
    j["category"] = Json(value.category);
    j["starterRole"] = Json(value.starterRole);
    j["priority"] = Json(value.priority.to!string);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json workflowInstanceToJson(ref WorkflowInstance value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["definitionId"] = Json(value.definitionId);
    j["businessObjectType"] = Json(value.businessObjectType);
    j["businessObjectId"] = Json(value.businessObjectId);
    j["status"] = Json(value.status.to!string);
    j["startedBy"] = Json(value.startedBy);
    j["startedAt"] = Json(value.startedAt);
    j["completedAt"] = Json(value.completedAt);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json workflowTaskToJson(ref WorkflowTask value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["instanceId"] = Json(value.instanceId);
    j["title"] = Json(value.title);
    j["assignee"] = Json(value.assignee);
    j["dueDate"] = Json(value.dueDate);
    j["priority"] = Json(value.priority.to!string);
    j["state"] = Json(value.state.to!string);
    j["completedBy"] = Json(value.completedBy);
    j["completedAt"] = Json(value.completedAt);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json approvalDecisionToJson(ref ApprovalDecision value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["taskId"] = Json(value.taskId);
    j["decision"] = Json(value.decision.to!string);
    j["comment"] = Json(value.comment);
    j["decidedBy"] = Json(value.decidedBy);
    j["decidedAt"] = Json(value.decidedAt);
    return j;
}

Json deadlineEscalationToJson(ref DeadlineEscalation value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["taskId"] = Json(value.taskId);
    j["escalationRole"] = Json(value.escalationRole);
    j["escalationAt"] = Json(value.escalationAt);
    j["reason"] = Json(value.reason);
    j["notified"] = Json(value.notified);
    return j;
}

Json workflowSubstitutionToJson(ref WorkflowSubstitution value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["principalUser"] = Json(value.principalUser);
    j["substituteUser"] = Json(value.substituteUser);
    j["validFrom"] = Json(value.validFrom);
    j["validTo"] = Json(value.validTo);
    j["active"] = Json(value.active);
    return j;
}

Json workflowContextToJson(ref WorkflowContext value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["instanceId"] = Json(value.instanceId);
    j["key"] = Json(value.key);
    j["value"] = Json(value.value);
    return j;
}

Json workflowEventToJson(ref WorkflowEvent value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["instanceId"] = Json(value.instanceId);
    j["kind"] = Json(value.kind.to!string);
    j["actor"] = Json(value.actor);
    j["occurredAt"] = Json(value.occurredAt);
    j["details"] = Json(value.details);
    return j;
}
