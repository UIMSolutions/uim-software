module uim.platform.workflow.domain.types;

@safe:

alias WorkflowDefinitionId = string;
alias WorkflowInstanceId = string;
alias WorkflowTaskId = string;
alias ApprovalDecisionId = string;
alias DeadlineEscalationId = string;
alias WorkflowSubstitutionId = string;
alias WorkflowContextId = string;
alias WorkflowEventId = string;
alias TenantId = string;

enum WorkflowLifecycle {
    draft,
    active,
    suspended,
    completed,
    cancelled
}

enum TaskState {
    ready,
    reserved,
    inProgress,
    completed,
    escalated,
    skipped
}

enum DecisionType {
    approve,
    reject,
    rework,
    information
}

enum Priority {
    low,
    normal,
    high,
    critical
}

enum EventKind {
    start,
    submit,
    complete,
    escalation,
    cancellation
}
