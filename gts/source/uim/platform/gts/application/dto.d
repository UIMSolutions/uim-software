module uim.platform.gts.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct BusinessPartnerDTO {
    string id;
    string tenantId;
    string name;
    string partnerRole;
    string country;
    string vatNumber;
    string status;
    string createdBy;
    string modifiedBy;
}

struct ProductClassificationDTO {
    string id;
    string tenantId;
    string productId;
    string description;
    string commodityCode;
    string exportControlClass;
    string originCountry;
    string status;
    string createdBy;
    string modifiedBy;
}

struct CustomsDeclarationDTO {
    string id;
    string tenantId;
    string flow;
    string declarationNumber;
    string partnerId;
    string productId;
    string customsOffice;
    string declarationDate;
    string procedureCode;
    string totalValue;
    string currency;
    string status;
    string createdBy;
    string modifiedBy;
}

struct TradeLicenseDTO {
    string id;
    string tenantId;
    string licenseType;
    string licenseNumber;
    string issuingAuthority;
    string validFrom;
    string validTo;
    string partnerId;
    string country;
    string status;
    string createdBy;
    string modifiedBy;
}

struct PreferenceAgreementDTO {
    string id;
    string tenantId;
    string scheme;
    string agreementCode;
    string beneficiaryCountry;
    string originRule;
    string validFrom;
    string validTo;
    string status;
    string createdBy;
    string modifiedBy;
}

struct SanctionedPartyCaseDTO {
    string id;
    string tenantId;
    string partnerName;
    string matchCode;
    string risk;
    string reviewedBy;
    string reviewDate;
    string status;
    string decisionReason;
    string createdBy;
    string modifiedBy;
}

struct EmbargoControlCaseDTO {
    string id;
    string tenantId;
    string destinationCountry;
    string productId;
    string embargoRegulation;
    string risk;
    string status;
    string reviewedBy;
    string decisionDate;
    string decisionReason;
    string createdBy;
    string modifiedBy;
}

struct IntrastatDeclarationDTO {
    string id;
    string tenantId;
    string reportingPeriod;
    string dispatchCountry;
    string arrivalCountry;
    string commodityCode;
    string netMass;
    string supplementaryUnits;
    string statisticalValue;
    string currency;
    string status;
    string createdBy;
    string modifiedBy;
}
