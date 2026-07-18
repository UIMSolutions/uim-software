module uim.platform.gts.infrastructure.container;

import uim.platform.gts;

@safe:

struct Container {
    AppConfig config;

    ManageBusinessPartnersUseCase manageBusinessPartnersUseCase;
    ManageProductClassificationsUseCase manageProductClassificationsUseCase;
    ManageCustomsDeclarationsUseCase manageCustomsDeclarationsUseCase;
    ManageTradeLicensesUseCase manageTradeLicensesUseCase;
    ManagePreferenceAgreementsUseCase managePreferenceAgreementsUseCase;
    ManageSanctionedPartyCasesUseCase manageSanctionedPartyCasesUseCase;
    ManageEmbargoControlCasesUseCase manageEmbargoControlCasesUseCase;
    ManageIntrastatDeclarationsUseCase manageIntrastatDeclarationsUseCase;

    GTSHealthController healthController;
    BusinessPartnerController businessPartnerController;
    ProductClassificationController productClassificationController;
    CustomsDeclarationController customsDeclarationController;
    TradeLicenseController tradeLicenseController;
    PreferenceAgreementController preferenceAgreementController;
    SanctionedPartyCaseController sanctionedPartyCaseController;
    EmbargoControlCaseController embargoControlCaseController;
    IntrastatDeclarationController intrastatDeclarationController;
}

Container buildContainer(AppConfig config) {
    Container container;
    container.config = config;

    auto businessPartnerRepo = new MemoryBusinessPartnerRepository();
    auto productClassificationRepo = new MemoryProductClassificationRepository();
    auto customsDeclarationRepo = new MemoryCustomsDeclarationRepository();
    auto tradeLicenseRepo = new MemoryTradeLicenseRepository();
    auto preferenceAgreementRepo = new MemoryPreferenceAgreementRepository();
    auto sanctionedPartyCaseRepo = new MemorySanctionedPartyCaseRepository();
    auto embargoControlCaseRepo = new MemoryEmbargoControlCaseRepository();
    auto intrastatDeclarationRepo = new MemoryIntrastatDeclarationRepository();

    container.manageBusinessPartnersUseCase = new ManageBusinessPartnersUseCase(businessPartnerRepo);
    container.manageProductClassificationsUseCase = new ManageProductClassificationsUseCase(productClassificationRepo);
    container.manageCustomsDeclarationsUseCase = new ManageCustomsDeclarationsUseCase(customsDeclarationRepo);
    container.manageTradeLicensesUseCase = new ManageTradeLicensesUseCase(tradeLicenseRepo);
    container.managePreferenceAgreementsUseCase = new ManagePreferenceAgreementsUseCase(preferenceAgreementRepo);
    container.manageSanctionedPartyCasesUseCase = new ManageSanctionedPartyCasesUseCase(sanctionedPartyCaseRepo);
    container.manageEmbargoControlCasesUseCase = new ManageEmbargoControlCasesUseCase(embargoControlCaseRepo);
    container.manageIntrastatDeclarationsUseCase = new ManageIntrastatDeclarationsUseCase(intrastatDeclarationRepo);

    container.healthController = new GTSHealthController();
    container.businessPartnerController = new BusinessPartnerController(container.manageBusinessPartnersUseCase);
    container.productClassificationController = new ProductClassificationController(container.manageProductClassificationsUseCase);
    container.customsDeclarationController = new CustomsDeclarationController(container.manageCustomsDeclarationsUseCase);
    container.tradeLicenseController = new TradeLicenseController(container.manageTradeLicensesUseCase);
    container.preferenceAgreementController = new PreferenceAgreementController(container.managePreferenceAgreementsUseCase);
    container.sanctionedPartyCaseController = new SanctionedPartyCaseController(container.manageSanctionedPartyCasesUseCase);
    container.embargoControlCaseController = new EmbargoControlCaseController(container.manageEmbargoControlCasesUseCase);
    container.intrastatDeclarationController = new IntrastatDeclarationController(container.manageIntrastatDeclarationsUseCase);

    return container;
}
