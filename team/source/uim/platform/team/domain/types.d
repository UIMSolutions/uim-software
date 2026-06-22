module uim.platform.team.domain.types;

@safe:

alias PartId = string;
alias BomId = string;
alias DocumentId = string;
alias ChangeId = string;
alias TenantId = string;

enum PartLifecycleState {
    inWork,
    released,
    obsolete
}

enum DocumentType {
    cad,
    specification,
    testReport,
    qualityRecord,
    workInstruction
}

enum ChangeState {
    draft,
    submitted,
    approved,
    implemented,
    rejected
}

enum Severity {
    low,
    medium,
    high,
    critical
}
