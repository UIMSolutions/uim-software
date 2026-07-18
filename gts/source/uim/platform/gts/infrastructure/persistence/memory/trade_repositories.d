module uim.platform.gts.infrastructure.persistence.repositories.trade_repositories;

import std.algorithm : remove;

import uim.platform.gts.domain.entities.trade_entities;
import uim.platform.gts.domain.repositories.trade_repositories;
import uim.platform.gts.domain.types;

@safe:

class MemoryBusinessPartnerRepository : BusinessPartnerRepository {
    private BusinessPartner[] store;

    BusinessPartner[] findAll() { return store; }

    private @trusted BusinessPartner* ptr(BusinessPartnerId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    BusinessPartner* findById(BusinessPartnerId id) { return ptr(id); }
    void save(BusinessPartner value) { store ~= value; }

    void update(BusinessPartner value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(BusinessPartnerId id) { store = store.remove!(x => x.id == id); }
}

class MemoryProductClassificationRepository : ProductClassificationRepository {
    private ProductClassification[] store;

    ProductClassification[] findAll() { return store; }

    private @trusted ProductClassification* ptr(ProductClassificationId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    ProductClassification* findById(ProductClassificationId id) { return ptr(id); }
    void save(ProductClassification value) { store ~= value; }

    void update(ProductClassification value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(ProductClassificationId id) { store = store.remove!(x => x.id == id); }
}

class MemoryCustomsDeclarationRepository : CustomsDeclarationRepository {
    private CustomsDeclaration[] store;

    CustomsDeclaration[] findAll() { return store; }

    private @trusted CustomsDeclaration* ptr(CustomsDeclarationId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    CustomsDeclaration* findById(CustomsDeclarationId id) { return ptr(id); }
    void save(CustomsDeclaration value) { store ~= value; }

    void update(CustomsDeclaration value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(CustomsDeclarationId id) { store = store.remove!(x => x.id == id); }
}

class MemoryTradeLicenseRepository : TradeLicenseRepository {
    private TradeLicense[] store;

    TradeLicense[] findAll() { return store; }

    private @trusted TradeLicense* ptr(TradeLicenseId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    TradeLicense* findById(TradeLicenseId id) { return ptr(id); }
    void save(TradeLicense value) { store ~= value; }

    void update(TradeLicense value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(TradeLicenseId id) { store = store.remove!(x => x.id == id); }
}

class MemoryPreferenceAgreementRepository : PreferenceAgreementRepository {
    private PreferenceAgreement[] store;

    PreferenceAgreement[] findAll() { return store; }

    private @trusted PreferenceAgreement* ptr(PreferenceAgreementId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    PreferenceAgreement* findById(PreferenceAgreementId id) { return ptr(id); }
    void save(PreferenceAgreement value) { store ~= value; }

    void update(PreferenceAgreement value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(PreferenceAgreementId id) { store = store.remove!(x => x.id == id); }
}

class MemorySanctionedPartyCaseRepository : SanctionedPartyCaseRepository {
    private SanctionedPartyCase[] store;

    SanctionedPartyCase[] findAll() { return store; }

    private @trusted SanctionedPartyCase* ptr(SanctionedPartyCaseId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    SanctionedPartyCase* findById(SanctionedPartyCaseId id) { return ptr(id); }
    void save(SanctionedPartyCase value) { store ~= value; }

    void update(SanctionedPartyCase value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(SanctionedPartyCaseId id) { store = store.remove!(x => x.id == id); }
}

class MemoryEmbargoControlCaseRepository : EmbargoControlCaseRepository {
    private EmbargoControlCase[] store;

    EmbargoControlCase[] findAll() { return store; }

    private @trusted EmbargoControlCase* ptr(EmbargoControlCaseId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    EmbargoControlCase* findById(EmbargoControlCaseId id) { return ptr(id); }
    void save(EmbargoControlCase value) { store ~= value; }

    void update(EmbargoControlCase value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(EmbargoControlCaseId id) { store = store.remove!(x => x.id == id); }
}

class MemoryIntrastatDeclarationRepository : IntrastatDeclarationRepository {
    private IntrastatDeclaration[] store;

    IntrastatDeclaration[] findAll() { return store; }

    private @trusted IntrastatDeclaration* ptr(IntrastatDeclarationId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    IntrastatDeclaration* findById(IntrastatDeclarationId id) { return ptr(id); }
    void save(IntrastatDeclaration value) { store ~= value; }

    void update(IntrastatDeclaration value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(IntrastatDeclarationId id) { store = store.remove!(x => x.id == id); }
}
