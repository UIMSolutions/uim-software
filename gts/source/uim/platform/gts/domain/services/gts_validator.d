module uim.platform.gts.domain.services.gts_validator;

import uim.platform.gts.domain.entities.trade_entities;

@safe:

struct GTSValidator {
    static bool hasRequired(string id, string tenantId, string name) {
        return id.length > 0 && tenantId.length > 0 && name.length > 0;
    }

    static bool valid(BusinessPartner value) {
        return hasRequired(value.id, value.tenantId, value.name);
    }

    static bool valid(ProductClassification value) {
        return hasRequired(value.id, value.tenantId, value.description)
            && value.commodityCode.length > 0;
    }

    static bool valid(CustomsDeclaration value) {
        return hasRequired(value.id, value.tenantId, value.declarationNumber)
            && value.partnerId.length > 0;
    }

    static bool valid(TradeLicense value) {
        return hasRequired(value.id, value.tenantId, value.licenseNumber);
    }

    static bool valid(PreferenceAgreement value) {
        return hasRequired(value.id, value.tenantId, value.agreementCode);
    }

    static bool valid(SanctionedPartyCase value) {
        return hasRequired(value.id, value.tenantId, value.partnerName);
    }

    static bool valid(EmbargoControlCase value) {
        return hasRequired(value.id, value.tenantId, value.destinationCountry);
    }

    static bool valid(IntrastatDeclaration value) {
        return hasRequired(value.id, value.tenantId, value.reportingPeriod)
            && value.commodityCode.length > 0;
    }
}
