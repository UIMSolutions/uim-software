module uim.platform.gts.presentation.http.json_utils;

import std.conv : to;

import uim.platform.gts;
import uim.platform.gts.domain.entities.trade_entities;

@safe:

Json businessPartnerToJson(ref BusinessPartner value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["name"] = Json(value.name);
    j["partnerRole"] = Json(value.partnerRole);
    j["country"] = Json(value.country);
    j["vatNumber"] = Json(value.vatNumber);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json productClassificationToJson(ref ProductClassification value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["productId"] = Json(value.productId);
    j["description"] = Json(value.description);
    j["commodityCode"] = Json(value.commodityCode);
    j["exportControlClass"] = Json(value.exportControlClass);
    j["originCountry"] = Json(value.originCountry);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json customsDeclarationToJson(ref CustomsDeclaration value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["flow"] = Json(value.flow.to!string);
    j["declarationNumber"] = Json(value.declarationNumber);
    j["partnerId"] = Json(value.partnerId);
    j["productId"] = Json(value.productId);
    j["customsOffice"] = Json(value.customsOffice);
    j["declarationDate"] = Json(value.declarationDate);
    j["procedureCode"] = Json(value.procedureCode);
    j["totalValue"] = Json(value.totalValue);
    j["currency"] = Json(value.currency);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json tradeLicenseToJson(ref TradeLicense value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["licenseType"] = Json(value.licenseType.to!string);
    j["licenseNumber"] = Json(value.licenseNumber);
    j["issuingAuthority"] = Json(value.issuingAuthority);
    j["validFrom"] = Json(value.validFrom);
    j["validTo"] = Json(value.validTo);
    j["partnerId"] = Json(value.partnerId);
    j["country"] = Json(value.country);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json preferenceAgreementToJson(ref PreferenceAgreement value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["scheme"] = Json(value.scheme.to!string);
    j["agreementCode"] = Json(value.agreementCode);
    j["beneficiaryCountry"] = Json(value.beneficiaryCountry);
    j["originRule"] = Json(value.originRule);
    j["validFrom"] = Json(value.validFrom);
    j["validTo"] = Json(value.validTo);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json sanctionedPartyCaseToJson(ref SanctionedPartyCase value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["partnerName"] = Json(value.partnerName);
    j["matchCode"] = Json(value.matchCode);
    j["risk"] = Json(value.risk.to!string);
    j["reviewedBy"] = Json(value.reviewedBy);
    j["reviewDate"] = Json(value.reviewDate);
    j["status"] = Json(value.status.to!string);
    j["decisionReason"] = Json(value.decisionReason);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json embargoControlCaseToJson(ref EmbargoControlCase value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["destinationCountry"] = Json(value.destinationCountry);
    j["productId"] = Json(value.productId);
    j["embargoRegulation"] = Json(value.embargoRegulation);
    j["risk"] = Json(value.risk.to!string);
    j["status"] = Json(value.status.to!string);
    j["reviewedBy"] = Json(value.reviewedBy);
    j["decisionDate"] = Json(value.decisionDate);
    j["decisionReason"] = Json(value.decisionReason);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}

Json intrastatDeclarationToJson(ref IntrastatDeclaration value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["reportingPeriod"] = Json(value.reportingPeriod);
    j["dispatchCountry"] = Json(value.dispatchCountry);
    j["arrivalCountry"] = Json(value.arrivalCountry);
    j["commodityCode"] = Json(value.commodityCode);
    j["netMass"] = Json(value.netMass);
    j["supplementaryUnits"] = Json(value.supplementaryUnits);
    j["statisticalValue"] = Json(value.statisticalValue);
    j["currency"] = Json(value.currency);
    j["status"] = Json(value.status.to!string);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    return j;
}
