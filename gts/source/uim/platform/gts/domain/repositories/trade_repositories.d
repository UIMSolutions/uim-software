module uim.platform.gts.domain.repositories.trade_repositories;

import uim.platform.gts.domain.entities.trade_entities;
import uim.platform.gts.domain.types;

@safe:

interface BusinessPartnerRepository {
    BusinessPartner[] findAll();
    BusinessPartner* findById(BusinessPartnerId id);
    void save(BusinessPartner value);
    void update(BusinessPartner value);
    void remove(BusinessPartnerId id);
}

interface ProductClassificationRepository {
    ProductClassification[] findAll();
    ProductClassification* findById(ProductClassificationId id);
    void save(ProductClassification value);
    void update(ProductClassification value);
    void remove(ProductClassificationId id);
}

interface CustomsDeclarationRepository {
    CustomsDeclaration[] findAll();
    CustomsDeclaration* findById(CustomsDeclarationId id);
    void save(CustomsDeclaration value);
    void update(CustomsDeclaration value);
    void remove(CustomsDeclarationId id);
}

interface TradeLicenseRepository {
    TradeLicense[] findAll();
    TradeLicense* findById(TradeLicenseId id);
    void save(TradeLicense value);
    void update(TradeLicense value);
    void remove(TradeLicenseId id);
}

interface PreferenceAgreementRepository {
    PreferenceAgreement[] findAll();
    PreferenceAgreement* findById(PreferenceAgreementId id);
    void save(PreferenceAgreement value);
    void update(PreferenceAgreement value);
    void remove(PreferenceAgreementId id);
}

interface SanctionedPartyCaseRepository {
    SanctionedPartyCase[] findAll();
    SanctionedPartyCase* findById(SanctionedPartyCaseId id);
    void save(SanctionedPartyCase value);
    void update(SanctionedPartyCase value);
    void remove(SanctionedPartyCaseId id);
}

interface EmbargoControlCaseRepository {
    EmbargoControlCase[] findAll();
    EmbargoControlCase* findById(EmbargoControlCaseId id);
    void save(EmbargoControlCase value);
    void update(EmbargoControlCase value);
    void remove(EmbargoControlCaseId id);
}

interface IntrastatDeclarationRepository {
    IntrastatDeclaration[] findAll();
    IntrastatDeclaration* findById(IntrastatDeclarationId id);
    void save(IntrastatDeclaration value);
    void update(IntrastatDeclaration value);
    void remove(IntrastatDeclarationId id);
}
