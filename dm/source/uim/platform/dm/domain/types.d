module uim.platform.dm.domain.types;

@safe:

alias ProductionOrderId = string;
alias OperationActivityId = string;
alias WorkCenterId = string;
alias ResourceId = string;
alias MaterialId = string;
alias ShopFloorControlId = string;
alias WorkInstructionId = string;
alias QualityInspectionId = string;
alias NonconformanceId = string;
alias GenealogyRecordId = string;
alias TenantId = string;

enum OrderStatus {
    planned,
    released,
    inExecution,
    paused,
    technicallyComplete,
    closed
}

enum OperationStatus {
    ready,
    started,
    blocked,
    completed,
    skipped
}

enum ResourceType {
    machine,
    labor,
    tool,
    fixture,
    device
}

enum ControlMode {
    pull,
    push,
    mixed
}

enum InspectionStatus {
    pending,
    inProgress,
    accepted,
    rejected,
    reworkRequired
}

enum NonconformanceSeverity {
    minor,
    major,
    critical
}
