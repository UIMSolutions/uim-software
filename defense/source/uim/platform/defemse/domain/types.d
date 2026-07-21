module uim.platform.defense.domain.types;

alias MissionPlanId = string;
alias ExerciseId = string;
alias ContingentId = string;
alias ReadinessProfileId = string;
alias RedeploymentOrderId = string;
alias MaintenanceTaskId = string;
alias BudgetTriggerId = string;
alias OfflineSyncRecordId = string;
alias TenantId = string;
alias UserId = string;

enum MissionStatus {
    planned,
    preparing,
    ready,
    deploying,
    inOperation,
    redeploying,
    disconnected,
    syncing,
    completed,
    cancelled
}

enum ExerciseStatus {
    planned,
    scheduled,
    running,
    completed,
    cancelled
}

enum ContingentStatus {
    available,
    preparing,
    deployed,
    redeploying,
    disconnected,
    maintenance
}

enum ReadinessStatus {
    low,
    medium,
    high,
    critical
}

enum RedeploymentStatus {
    requested,
    approved,
    executing,
    completed,
    cancelled
}

enum MaintenanceTaskStatus {
    planned,
    scheduled,
    inProgress,
    completed,
    cancelled
}

enum BudgetTriggerStatus {
    requested,
    approved,
    executed,
    failed,
    cancelled
}

enum OfflineSyncStatus {
    pending,
    synced,
    conflict,
    failed
}
