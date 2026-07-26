module uim.platform.workflow.domain.services.workflow_validator;

import uim.platform.workflow.domain.entities.workflow_entities;

@safe:

struct WorkflowValidator {
    static bool hasRequired(string id, string tenantId, string name) {
        return id.length > 0 && tenantId.length > 0 && name.length > 0;
    }

    static bool valid(WorkflowDefinition value) {
        return hasRequired(value.id, value.tenantId, value.name);
    }

    static bool valid(WorkflowInstance value) {
        return hasRequired(value.id, value.tenantId, value.definitionId)
            && value.businessObjectId.length > 0;
    }

    static bool valid(WorkflowTask value) {
        return hasRequired(value.id, value.tenantId, value.title)
            && value.instanceId.length > 0;
    }

    static bool valid(ApprovalDecision value) {
        return hasRequired(value.id, value.tenantId, value.taskId)
            && value.decidedBy.length > 0;
    }

    static bool valid(DeadlineEscalation value) {
        return hasRequired(value.id, value.tenantId, value.taskId)
            && value.escalationRole.length > 0;
    }

    static bool valid(WorkflowSubstitution value) {
        return hasRequired(value.id, value.tenantId, value.principalUser)
            && value.substituteUser.length > 0;
    }

    static bool valid(WorkflowContext value) {
        return hasRequired(value.id, value.tenantId, value.key)
            && value.instanceId.length > 0;
    }

    static bool valid(WorkflowEvent value) {
        return hasRequired(value.id, value.tenantId, value.instanceId)
            && value.actor.length > 0;
    }
}
