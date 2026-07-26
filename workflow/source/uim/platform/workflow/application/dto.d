module uim.platform.workflow.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct WorkflowDefinitionDTO {
    string id;
    string tenantId;
    string name;
    string category;
    string starterRole;
    string priority;
    string status;
    string createdBy;
    string modifiedBy;
}

struct WorkflowInstanceDTO {
    string id;
    string tenantId;
    string definitionId;
    string businessObjectType;
    string businessObjectId;
    string status;
    string startedBy;
    string startedAt;
    string completedAt;
    string modifiedBy;
}

struct WorkflowTaskDTO {
    string id;
    string tenantId;
    string instanceId;
    string title;
    string assignee;
    string dueDate;
    string priority;
    string state;
    string completedBy;
    string completedAt;
    string modifiedBy;
}

struct ApprovalDecisionDTO {
    string id;
    string tenantId;
    string taskId;
    string decision;
    string comment;
    string decidedBy;
    string decidedAt;
}

struct DeadlineEscalationDTO {
    string id;
    string tenantId;
    string taskId;
    string escalationRole;
    string escalationAt;
    string reason;
    bool notified;
}

struct WorkflowSubstitutionDTO {
    string id;
    string tenantId;
    string principalUser;
    string substituteUser;
    string validFrom;
    string validTo;
    bool active;
}

struct WorkflowContextDTO {
    string id;
    string tenantId;
    string instanceId;
    string key;
    string value;
}

struct WorkflowEventDTO {
    string id;
    string tenantId;
    string instanceId;
    string kind;
    string actor;
    string occurredAt;
    string details;
}
