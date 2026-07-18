module uim.platform.gts.domain.entities.trade_entities;

import uim.platform.gts.domain.types;

@safe:

struct BusinessPartner {
    BusinessPartnerId id;
    TenantId tenantId;
    string name;
    string partnerRole;
    string country;
    string vatNumber;
    ComplianceStatus status = ComplianceStatus.draft;
    string createdBy;
    string modifiedBy;
}

struct ProductClassification {
    ProductClassificationId id;
    TenantId tenantId;
    string productId;
    string description;
    string commodityCode;
    string exportControlClass;
    string originCountry;
    ComplianceStatus status = ComplianceStatus.draft;
    string createdBy;
    string modifiedBy;
}

struct CustomsDeclaration {
    CustomsDeclarationId id;
    TenantId tenantId;
    TradeFlow flow = TradeFlow.export_;
    string declarationNumber;
    string partnerId;
    string productId;
    string customsOffice;
    string declarationDate;
    string procedureCode;
    string totalValue;
    string currency;
    DeclarationStatus status = DeclarationStatus.prepared;
    string createdBy;
    string modifiedBy;
}

struct TradeLicense {
    TradeLicenseId id;
    TenantId tenantId;
    LicenseType licenseType = LicenseType.exportLicense;
    string licenseNumber;
    string issuingAuthority;
    string validFrom;
    string validTo;
    string partnerId;
    string country;
    ComplianceStatus status = ComplianceStatus.draft;
    string createdBy;
    string modifiedBy;
}

struct PreferenceAgreement {
    PreferenceAgreementId id;
    TenantId tenantId;
    PreferenceScheme scheme = PreferenceScheme.fta;
    string agreementCode;
    string beneficiaryCountry;
    string originRule;
    string validFrom;
    string validTo;
    ComplianceStatus status = ComplianceStatus.draft;
    string createdBy;
    string modifiedBy;
}

struct SanctionedPartyCase {
    SanctionedPartyCaseId id;
    TenantId tenantId;
    string partnerName;
    string matchCode;
    RiskLevel risk = RiskLevel.medium;
    string reviewedBy;
    string reviewDate;
    ComplianceStatus status = ComplianceStatus.draft;
    string decisionReason;
    string createdBy;
    string modifiedBy;
}

struct EmbargoControlCase {
    EmbargoControlCaseId id;
    TenantId tenantId;
    string destinationCountry;
    string productId;
    string embargoRegulation;
    RiskLevel risk = RiskLevel.medium;
    ComplianceStatus status = ComplianceStatus.draft;
    string reviewedBy;
    string decisionDate;
    string decisionReason;
    string createdBy;
    string modifiedBy;
}

struct IntrastatDeclaration {
    IntrastatDeclarationId id;
    TenantId tenantId;
    string reportingPeriod;
    string dispatchCountry;
    string arrivalCountry;
    string commodityCode;
    string netMass;
    string supplementaryUnits;
    string statisticalValue;
    string currency;
    DeclarationStatus status = DeclarationStatus.prepared;
    string createdBy;
    string modifiedBy;
}
