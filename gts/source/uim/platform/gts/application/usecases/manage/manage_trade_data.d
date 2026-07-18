module uim.platform.gts.application.usecases.manage.manage_trade_data;

import std.string : toLower;

import uim.platform.gts.application.dto;
import uim.platform.gts.domain.entities.trade_entities;
import uim.platform.gts.domain.repositories.trade_repositories;
import uim.platform.gts.domain.services.gts_validator;
import uim.platform.gts.domain.types;

@safe:

private ComplianceStatus parseComplianceStatus(string value, ComplianceStatus fallback = ComplianceStatus.draft) {
    switch (value.toLower()) {
        case "draft": return ComplianceStatus.draft;
        case "active": return ComplianceStatus.active;
        case "blocked": return ComplianceStatus.blocked;
        case "released": return ComplianceStatus.released;
        case "closed": return ComplianceStatus.closed;
        default: return fallback;
    }
}

private DeclarationStatus parseDeclarationStatus(string value, DeclarationStatus fallback = DeclarationStatus.prepared) {
    switch (value.toLower()) {
        case "prepared": return DeclarationStatus.prepared;
        case "submitted": return DeclarationStatus.submitted;
        case "accepted": return DeclarationStatus.accepted;
        case "rejected": return DeclarationStatus.rejected;
        case "cancelled": return DeclarationStatus.cancelled;
        default: return fallback;
    }
}

private TradeFlow parseTradeFlow(string value, TradeFlow fallback = TradeFlow.export_) {
    switch (value.toLower()) {
        case "import":
        case "import_": return TradeFlow.import_;
        case "export":
        case "export_": return TradeFlow.export_;
        default: return fallback;
    }
}

private LicenseType parseLicenseType(string value, LicenseType fallback = LicenseType.exportLicense) {
    switch (value.toLower()) {
        case "importlicense": return LicenseType.importLicense;
        case "exportlicense": return LicenseType.exportLicense;
        case "dualuse": return LicenseType.dualUse;
        case "military": return LicenseType.military;
        case "quota": return LicenseType.quota;
        default: return fallback;
    }
}

private RiskLevel parseRiskLevel(string value, RiskLevel fallback = RiskLevel.medium) {
    switch (value.toLower()) {
        case "low": return RiskLevel.low;
        case "medium": return RiskLevel.medium;
        case "high": return RiskLevel.high;
        case "critical": return RiskLevel.critical;
        default: return fallback;
    }
}

private PreferenceScheme parsePreferenceScheme(string value, PreferenceScheme fallback = PreferenceScheme.fta) {
    switch (value.toLower()) {
        case "fta": return PreferenceScheme.fta;
        case "gsp": return PreferenceScheme.gsp;
        case "bilateral": return PreferenceScheme.bilateral;
        case "regional": return PreferenceScheme.regional;
        case "customsunion": return PreferenceScheme.customsUnion;
        default: return fallback;
    }
}

class ManageBusinessPartnersUseCase {
    private BusinessPartnerRepository repo;

    this(BusinessPartnerRepository repo) { this.repo = repo; }

    BusinessPartner[] list() { return repo.findAll(); }
    BusinessPartner* get_(BusinessPartnerId id) { return repo.findById(id); }

    CommandResult create(BusinessPartnerDTO dto) {
        BusinessPartner value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.name = dto.name;
        value.partnerRole = dto.partnerRole;
        value.country = dto.country;
        value.vatNumber = dto.vatNumber;
        value.status = parseComplianceStatus(dto.status);
        value.createdBy = dto.createdBy;

        if (!GTSValidator.valid(value))
            return CommandResult(false, "", "Invalid business partner data");

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(BusinessPartnerDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Business partner not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.partnerRole.length > 0) existing.partnerRole = dto.partnerRole;
        if (dto.country.length > 0) existing.country = dto.country;
        if (dto.vatNumber.length > 0) existing.vatNumber = dto.vatNumber;
        if (dto.status.length > 0) existing.status = parseComplianceStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(BusinessPartnerId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Business partner not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageProductClassificationsUseCase {
    private ProductClassificationRepository repo;

    this(ProductClassificationRepository repo) { this.repo = repo; }

    ProductClassification[] list() { return repo.findAll(); }
    ProductClassification* get_(ProductClassificationId id) { return repo.findById(id); }

    CommandResult create(ProductClassificationDTO dto) {
        ProductClassification value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.productId = dto.productId;
        value.description = dto.description;
        value.commodityCode = dto.commodityCode;
        value.exportControlClass = dto.exportControlClass;
        value.originCountry = dto.originCountry;
        value.status = parseComplianceStatus(dto.status);
        value.createdBy = dto.createdBy;

        if (!GTSValidator.valid(value))
            return CommandResult(false, "", "Invalid product classification data");

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(ProductClassificationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Product classification not found");

        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.commodityCode.length > 0) existing.commodityCode = dto.commodityCode;
        if (dto.exportControlClass.length > 0) existing.exportControlClass = dto.exportControlClass;
        if (dto.originCountry.length > 0) existing.originCountry = dto.originCountry;
        if (dto.status.length > 0) existing.status = parseComplianceStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProductClassificationId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Product classification not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageCustomsDeclarationsUseCase {
    private CustomsDeclarationRepository repo;

    this(CustomsDeclarationRepository repo) { this.repo = repo; }

    CustomsDeclaration[] list() { return repo.findAll(); }
    CustomsDeclaration* get_(CustomsDeclarationId id) { return repo.findById(id); }

    CommandResult create(CustomsDeclarationDTO dto) {
        CustomsDeclaration value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.flow = parseTradeFlow(dto.flow);
        value.declarationNumber = dto.declarationNumber;
        value.partnerId = dto.partnerId;
        value.productId = dto.productId;
        value.customsOffice = dto.customsOffice;
        value.declarationDate = dto.declarationDate;
        value.procedureCode = dto.procedureCode;
        value.totalValue = dto.totalValue;
        value.currency = dto.currency;
        value.status = parseDeclarationStatus(dto.status);
        value.createdBy = dto.createdBy;

        if (!GTSValidator.valid(value))
            return CommandResult(false, "", "Invalid customs declaration data");

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(CustomsDeclarationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Customs declaration not found");

        if (dto.declarationNumber.length > 0) existing.declarationNumber = dto.declarationNumber;
        if (dto.customsOffice.length > 0) existing.customsOffice = dto.customsOffice;
        if (dto.procedureCode.length > 0) existing.procedureCode = dto.procedureCode;
        if (dto.totalValue.length > 0) existing.totalValue = dto.totalValue;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.flow.length > 0) existing.flow = parseTradeFlow(dto.flow, existing.flow);
        if (dto.status.length > 0) existing.status = parseDeclarationStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(CustomsDeclarationId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Customs declaration not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageTradeLicensesUseCase {
    private TradeLicenseRepository repo;

    this(TradeLicenseRepository repo) { this.repo = repo; }

    TradeLicense[] list() { return repo.findAll(); }
    TradeLicense* get_(TradeLicenseId id) { return repo.findById(id); }

    CommandResult create(TradeLicenseDTO dto) {
        TradeLicense value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.licenseType = parseLicenseType(dto.licenseType);
        value.licenseNumber = dto.licenseNumber;
        value.issuingAuthority = dto.issuingAuthority;
        value.validFrom = dto.validFrom;
        value.validTo = dto.validTo;
        value.partnerId = dto.partnerId;
        value.country = dto.country;
        value.status = parseComplianceStatus(dto.status);
        value.createdBy = dto.createdBy;

        if (!GTSValidator.valid(value))
            return CommandResult(false, "", "Invalid trade license data");

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(TradeLicenseDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Trade license not found");

        if (dto.licenseNumber.length > 0) existing.licenseNumber = dto.licenseNumber;
        if (dto.issuingAuthority.length > 0) existing.issuingAuthority = dto.issuingAuthority;
        if (dto.validFrom.length > 0) existing.validFrom = dto.validFrom;
        if (dto.validTo.length > 0) existing.validTo = dto.validTo;
        if (dto.country.length > 0) existing.country = dto.country;
        if (dto.licenseType.length > 0) existing.licenseType = parseLicenseType(dto.licenseType, existing.licenseType);
        if (dto.status.length > 0) existing.status = parseComplianceStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(TradeLicenseId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Trade license not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManagePreferenceAgreementsUseCase {
    private PreferenceAgreementRepository repo;

    this(PreferenceAgreementRepository repo) { this.repo = repo; }

    PreferenceAgreement[] list() { return repo.findAll(); }
    PreferenceAgreement* get_(PreferenceAgreementId id) { return repo.findById(id); }

    CommandResult create(PreferenceAgreementDTO dto) {
        PreferenceAgreement value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.scheme = parsePreferenceScheme(dto.scheme);
        value.agreementCode = dto.agreementCode;
        value.beneficiaryCountry = dto.beneficiaryCountry;
        value.originRule = dto.originRule;
        value.validFrom = dto.validFrom;
        value.validTo = dto.validTo;
        value.status = parseComplianceStatus(dto.status);
        value.createdBy = dto.createdBy;

        if (!GTSValidator.valid(value))
            return CommandResult(false, "", "Invalid preference agreement data");

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(PreferenceAgreementDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Preference agreement not found");

        if (dto.beneficiaryCountry.length > 0) existing.beneficiaryCountry = dto.beneficiaryCountry;
        if (dto.originRule.length > 0) existing.originRule = dto.originRule;
        if (dto.validFrom.length > 0) existing.validFrom = dto.validFrom;
        if (dto.validTo.length > 0) existing.validTo = dto.validTo;
        if (dto.scheme.length > 0) existing.scheme = parsePreferenceScheme(dto.scheme, existing.scheme);
        if (dto.status.length > 0) existing.status = parseComplianceStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(PreferenceAgreementId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Preference agreement not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageSanctionedPartyCasesUseCase {
    private SanctionedPartyCaseRepository repo;

    this(SanctionedPartyCaseRepository repo) { this.repo = repo; }

    SanctionedPartyCase[] list() { return repo.findAll(); }
    SanctionedPartyCase* get_(SanctionedPartyCaseId id) { return repo.findById(id); }

    CommandResult create(SanctionedPartyCaseDTO dto) {
        SanctionedPartyCase value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.partnerName = dto.partnerName;
        value.matchCode = dto.matchCode;
        value.risk = parseRiskLevel(dto.risk);
        value.reviewedBy = dto.reviewedBy;
        value.reviewDate = dto.reviewDate;
        value.status = parseComplianceStatus(dto.status);
        value.decisionReason = dto.decisionReason;
        value.createdBy = dto.createdBy;

        if (!GTSValidator.valid(value))
            return CommandResult(false, "", "Invalid sanctioned party case data");

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(SanctionedPartyCaseDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Sanctioned party case not found");

        if (dto.matchCode.length > 0) existing.matchCode = dto.matchCode;
        if (dto.reviewedBy.length > 0) existing.reviewedBy = dto.reviewedBy;
        if (dto.reviewDate.length > 0) existing.reviewDate = dto.reviewDate;
        if (dto.decisionReason.length > 0) existing.decisionReason = dto.decisionReason;
        if (dto.risk.length > 0) existing.risk = parseRiskLevel(dto.risk, existing.risk);
        if (dto.status.length > 0) existing.status = parseComplianceStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(SanctionedPartyCaseId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Sanctioned party case not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageEmbargoControlCasesUseCase {
    private EmbargoControlCaseRepository repo;

    this(EmbargoControlCaseRepository repo) { this.repo = repo; }

    EmbargoControlCase[] list() { return repo.findAll(); }
    EmbargoControlCase* get_(EmbargoControlCaseId id) { return repo.findById(id); }

    CommandResult create(EmbargoControlCaseDTO dto) {
        EmbargoControlCase value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.destinationCountry = dto.destinationCountry;
        value.productId = dto.productId;
        value.embargoRegulation = dto.embargoRegulation;
        value.risk = parseRiskLevel(dto.risk);
        value.status = parseComplianceStatus(dto.status);
        value.reviewedBy = dto.reviewedBy;
        value.decisionDate = dto.decisionDate;
        value.decisionReason = dto.decisionReason;
        value.createdBy = dto.createdBy;

        if (!GTSValidator.valid(value))
            return CommandResult(false, "", "Invalid embargo control case data");

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(EmbargoControlCaseDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Embargo control case not found");

        if (dto.destinationCountry.length > 0) existing.destinationCountry = dto.destinationCountry;
        if (dto.embargoRegulation.length > 0) existing.embargoRegulation = dto.embargoRegulation;
        if (dto.reviewedBy.length > 0) existing.reviewedBy = dto.reviewedBy;
        if (dto.decisionDate.length > 0) existing.decisionDate = dto.decisionDate;
        if (dto.decisionReason.length > 0) existing.decisionReason = dto.decisionReason;
        if (dto.risk.length > 0) existing.risk = parseRiskLevel(dto.risk, existing.risk);
        if (dto.status.length > 0) existing.status = parseComplianceStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(EmbargoControlCaseId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Embargo control case not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageIntrastatDeclarationsUseCase {
    private IntrastatDeclarationRepository repo;

    this(IntrastatDeclarationRepository repo) { this.repo = repo; }

    IntrastatDeclaration[] list() { return repo.findAll(); }
    IntrastatDeclaration* get_(IntrastatDeclarationId id) { return repo.findById(id); }

    CommandResult create(IntrastatDeclarationDTO dto) {
        IntrastatDeclaration value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.reportingPeriod = dto.reportingPeriod;
        value.dispatchCountry = dto.dispatchCountry;
        value.arrivalCountry = dto.arrivalCountry;
        value.commodityCode = dto.commodityCode;
        value.netMass = dto.netMass;
        value.supplementaryUnits = dto.supplementaryUnits;
        value.statisticalValue = dto.statisticalValue;
        value.currency = dto.currency;
        value.status = parseDeclarationStatus(dto.status);
        value.createdBy = dto.createdBy;

        if (!GTSValidator.valid(value))
            return CommandResult(false, "", "Invalid intrastat declaration data");

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(IntrastatDeclarationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Intrastat declaration not found");

        if (dto.reportingPeriod.length > 0) existing.reportingPeriod = dto.reportingPeriod;
        if (dto.dispatchCountry.length > 0) existing.dispatchCountry = dto.dispatchCountry;
        if (dto.arrivalCountry.length > 0) existing.arrivalCountry = dto.arrivalCountry;
        if (dto.commodityCode.length > 0) existing.commodityCode = dto.commodityCode;
        if (dto.netMass.length > 0) existing.netMass = dto.netMass;
        if (dto.supplementaryUnits.length > 0) existing.supplementaryUnits = dto.supplementaryUnits;
        if (dto.statisticalValue.length > 0) existing.statisticalValue = dto.statisticalValue;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.status.length > 0) existing.status = parseDeclarationStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(IntrastatDeclarationId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Intrastat declaration not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
