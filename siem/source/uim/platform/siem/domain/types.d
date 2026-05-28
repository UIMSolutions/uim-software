/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.types;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

// --- ID Aliases ---
alias SecurityEventId     = string;
alias AlertId             = string;
alias IncidentId          = string;
alias CorrelationRuleId   = string;
alias AssetId             = string;
alias ThreatIndicatorId   = string;
alias TenantId            = string;
alias UserId              = string;

// --- Enumerations ---

enum EventSeverity {
    informational,
    low,
    medium,
    high,
    critical
}

enum EventStatus {
    new_,
    processing,
    processed,
    suppressed,
    archived
}

enum EventSource {
    syslog,
    cef,
    leef,
    json,
    windows,
    linux,
    cloud,
    network,
    endpoint,
    application
}

enum AlertSeverity {
    informational,
    low,
    medium,
    high,
    critical
}

enum AlertStatus {
    open,
    investigating,
    resolved,
    falsePositive,
    suppressed
}

enum IncidentStatus {
    open,
    investigating,
    containment,
    eradication,
    recovery,
    closed,
    postIncidentReview
}

enum IncidentSeverity {
    low,
    medium,
    high,
    critical
}

enum RuleStatus {
    enabled,
    disabled,
    draft,
    testing
}

enum RuleType {
    threshold,
    correlation,
    anomaly,
    threatIntelligence,
    behavioral,
    sequence
}

enum AssetType {
    server,
    workstation,
    networkDevice,
    cloudInstance,
    container,
    iot,
    mobile,
    application
}

enum AssetCriticality {
    low,
    medium,
    high,
    critical
}

enum ThreatIndicatorType {
    ip,
    domain,
    url,
    hash,
    email,
    filename,
    registry,
    certificate
}

enum ThreatIndicatorConfidence {
    low,
    medium,
    high
}
