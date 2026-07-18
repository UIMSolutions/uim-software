module uim.platform.gts.domain.types;

@safe:

alias BusinessPartnerId = string;
alias ProductClassificationId = string;
alias CustomsDeclarationId = string;
alias TradeLicenseId = string;
alias PreferenceAgreementId = string;
alias SanctionedPartyCaseId = string;
alias EmbargoControlCaseId = string;
alias IntrastatDeclarationId = string;
alias TenantId = string;

enum TradeFlow {
    import_,
    export_
}

enum ComplianceStatus {
    draft,
    active,
    blocked,
    released,
    closed
}

enum DeclarationStatus {
    prepared,
    submitted,
    accepted,
    rejected,
    cancelled
}

enum LicenseType {
    importLicense,
    exportLicense,
    dualUse,
    military,
    quota
}

enum RiskLevel {
    low,
    medium,
    high,
    critical
}

enum PreferenceScheme {
    fta,
    gsp,
    bilateral,
    regional,
    customsUnion
}
