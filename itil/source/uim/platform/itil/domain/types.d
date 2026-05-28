/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.types;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

// --- ID Aliases ---
alias ITServiceId = string;
alias ServiceRequestId = string;
alias IncidentId = string;
alias ProblemId = string;
alias ChangeRecordId = string;
alias ConfigurationItemId = string;
alias ServiceLevelAgreementId = string;
alias KnowledgeArticleId = string;
alias ReleaseRecordId = string;
alias MonitoringEventId = string;
alias ImprovementItemId = string;
alias ITAssetId = string;
alias TenantId = string;
alias UserId = string;

// --- Enumerations ---

enum RecordStatus {
    open,
    inProgress,
    pending,
    resolved,
    closed,
    cancelled
}

enum Priority {
    critical,
    high,
    medium,
    low
}

enum IncidentCategory {
    hardware,
    software,
    network,
    security,
    performance,
    access,
    other
}

enum ProblemStatus {
    identified,
    inAnalysis,
    rootCauseFound,
    knownError,
    resolved,
    closed
}

enum ChangeType {
    standard,
    normal,
    emergency
}

enum ChangeStatus {
    draft,
    requested,
    authorized,
    scheduled,
    implemented,
    reviewComplete,
    closed,
    cancelled
}

enum ChangeRisk {
    low,
    medium,
    high,
    veryHigh
}

enum CIType {
    hardware,
    software,
    service,
    database,
    network,
    virtual_,
    cloud,
    documentation
}

enum CIStatus {
    active,
    inactive,
    retired,
    maintenance,
    disposed
}

enum SLAStatus {
    draft,
    active,
    expired,
    breached,
    closed
}

enum KnowledgeStatus {
    draft,
    underReview,
    approved,
    retired
}

enum ReleaseType {
    major,
    minor,
    patch,
    emergency
}

enum ReleaseStatus {
    planned,
    building,
    testing,
    deployed,
    failed,
    cancelled
}

enum EventSeverity {
    critical,
    major,
    minor,
    warning,
    informational
}

enum EventStatus {
    open,
    acknowledged,
    resolved,
    closed
}

enum ImprovementStatus {
    identified,
    inProgress,
    completed,
    cancelled
}

enum AssetStatus {
    active,
    inactive,
    disposed,
    lost,
    stolen
}

enum AssetType {
    hardware,
    software,
    license,
    consumable,
    infrastructure
}
