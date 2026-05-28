/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.types;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

// --- ID Aliases ---
alias ObjectiveId = string;
alias PlatformId = string;
alias InitiativeId = string;
alias OrganizationId = string;
alias BusinessCapabilityId = string;
alias BusinessContextId = string;
alias DataObjectId = string;
alias LeanApplicationId = string;
alias AppInterfaceId = string;
alias ProviderId = string;
alias ITComponentId = string;
alias TechCategoryId = string;
alias TenantId = string;
alias UserId = string;

// --- Enumerations ---

enum FactSheetStatus {
    active,
    draft,
    archived,
    endOfLife
}

enum FactSheetLayer {
    strategy,
    business,
    applicationData,
    technical
}

enum ObjectiveType {
    strategic,
    operational,
    transformation,
    compliance,
    innovation
}

enum InitiativeStatus {
    planned,
    active,
    onHold,
    completed,
    cancelled
}

enum InitiativePhase {
    discover,
    design,
    plan,
    build,
    deploy,
    retire
}

enum MaturityLevel {
    initial,
    managed,
    defined,
    quantitative,
    optimizing
}

enum ApplicationType {
    internal,
    external_,
    saas,
    paas,
    iaas,
    onPremise,
    hybrid
}

enum ApplicationLifecycleStatus {
    active,
    phaseIn,
    phaseOut,
    endOfLife,
    planned
}

enum ApplicationFunctionalFit {
    inappropriate,
    adequate,
    appropriate,
    perfect
}

enum ApplicationTechnicalFit {
    inappropriate,
    adequate,
    appropriate,
    perfect
}

enum InterfaceDirection {
    upstream,
    downstream,
    bidirectional
}

enum InterfaceFrequency {
    realtime,
    nearRealtime,
    batch,
    event,
    manual
}

enum ITComponentType {
    software,
    hardware,
    middleware,
    database,
    cloud,
    container,
    network,
    security,
    monitoring
}

enum ITComponentLifecycleStatus {
    active,
    phaseIn,
    phaseOut,
    endOfLife,
    planned
}

enum DataClassification {
    public_,
    internal_,
    confidential,
    restricted,
    secret
}

enum RiskStatus {
    active,
    mitigated,
    accepted,
    resolved
}

enum RiskLevel {
    low,
    medium,
    high,
    critical
}
