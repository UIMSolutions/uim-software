module uim.platform.workflow.domain.entities.workflow_entities;

import uim.platform.workflow.domain.types;

@safe:

struct WorkflowDefinition {
    WorkflowDefinitionId id;
    TenantId tenantId;
    string name;
    string category;
    string starterRole;
    Priority priority = Priority.normal;
    WorkflowLifecycle status = WorkflowLifecycle.draft;
    string createdBy;
    string modifiedBy;
}

struct WorkflowInstance {
    WorkflowInstanceId id;
    TenantId tenantId;
    string definitionId;
    string businessObjectType;
    string businessObjectId;
    WorkflowLifecycle status = WorkflowLifecycle.active;
    string startedBy;
    string startedAt;
    string completedAt;
    string modifiedBy;
}

struct WorkflowTask {
    WorkflowTaskId id;
    TenantId tenantId;
    string instanceId;
    string title;
    string assignee;
    string dueDate;
    Priority priority = Priority.normal;
    TaskState state = TaskState.ready;
    string completedBy;
    string completedAt;
    string modifiedBy;
}

struct ApprovalDecision {
    ApprovalDecisionId id;
    TenantId tenantId;
    string taskId;
    DecisionType decision = DecisionType.approve;
    string comment;
    string decidedBy;
    string decidedAt;
}

struct DeadlineEscalation {
    DeadlineEscalationId id;
    TenantId tenantId;
    string taskId;
    string escalationRole;
    string escalationAt;
    string reason;
    bool notified;
}

struct WorkflowSubstitution {
    WorkflowSubstitutionId id;
    TenantId tenantId;
    string principalUser;
    string substituteUser;
    string validFrom;
    string validTo;
    bool active;
}

struct WorkflowContext {
    WorkflowContextId id;
    TenantId tenantId;
    string instanceId;
    string key;
    string value;
}

struct WorkflowEvent {
    WorkflowEventId id;
    TenantId tenantId;
    string instanceId;
    EventKind kind = EventKind.start;
    string actor;
    string occurredAt;
    string details;
}
