module uim.platform.alm.domain.types;

@safe:

alias TenantId = string;
alias SolutionId = string;
alias ProjectId = string;
alias TaskId = string;
alias TestPlanId = string;
alias TestCaseId = string;
alias DefectId = string;
alias ReleaseId = string;
alias DeploymentId = string;
alias EnvironmentId = string;
alias AlertId = string;

enum SolutionLifecycleStage {
    explore,
    design,
    build,
    test,
    deploy,
    run,
    retire
}

enum ProjectStatus {
    planned,
    active,
    blocked,
    completed,
    cancelled
}

enum TaskStatus {
    backlog,
    ready,
    inProgress,
    blocked,
    done,
    cancelled
}

enum TestPlanStatus {
    draft,
    scheduled,
    executing,
    completed,
    archived
}

enum TestCaseStatus {
    draft,
    ready,
    executing,
    passed,
    failed,
    obsolete
}

enum DefectSeverity {
    low,
    medium,
    high,
    critical
}

enum DefectStatus {
    new_,
    triaged,
    inProgress,
    fixed,
    closed,
    deferred
}

enum ReleaseStatus {
    draft,
    planned,
    ready,
    deployed,
    rolledBack,
    archived
}

enum DeploymentStatus {
    scheduled,
    running,
    succeeded,
    failed,
    reverted
}

enum EnvironmentType {
    dev,
    test,
    qa,
    preprod,
    prod,
    training
}

enum AlertSeverity {
    info,
    warning,
    major,
    critical
}

enum AlertStatus {
    open,
    acknowledged,
    resolved,
    closed
}

enum RiskLevel {
    low,
    moderate,
    high,
    severe
}
