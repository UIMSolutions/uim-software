module uim.platform.gts.application.usecases.manage.gts_feature_tests;

import uim.platform.gts;

@safe unittest {
    auto repo = new MemoryBusinessPartnerRepository();
    auto uc = new ManageBusinessPartnersUseCase(repo);

    BusinessPartnerDTO dto;
    dto.id = "BP-100";
    dto.tenantId = "TEN-1";
    dto.name = "Atlas Logistics GmbH";
    dto.partnerRole = "Importer";
    dto.country = "DE";
    dto.status = "active";
    dto.createdBy = "seed";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].name == "Atlas Logistics GmbH");
}

@safe unittest {
    auto repo = new MemoryCustomsDeclarationRepository();
    auto uc = new ManageCustomsDeclarationsUseCase(repo);

    CustomsDeclarationDTO dto;
    dto.id = "CD-42";
    dto.tenantId = "TEN-1";
    dto.flow = "export";
    dto.declarationNumber = "EX-2026-00042";
    dto.partnerId = "BP-100";
    dto.productId = "MAT-11";
    dto.customsOffice = "DEHAM";
    dto.status = "submitted";
    dto.createdBy = "planner";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].declarationNumber == "EX-2026-00042");
}

@safe unittest {
    auto repo = new MemoryTradeLicenseRepository();
    auto uc = new ManageTradeLicensesUseCase(repo);

    TradeLicenseDTO dto;
    dto.id = "LIC-10";
    dto.tenantId = "TEN-1";
    dto.licenseType = "dualuse";
    dto.licenseNumber = "EU-DU-9001";
    dto.issuingAuthority = "BAFA";
    dto.validFrom = "2026-01-01";
    dto.validTo = "2027-12-31";
    dto.partnerId = "BP-100";
    dto.country = "DE";
    dto.status = "active";
    dto.createdBy = "compliance";

    auto result = uc.create(dto);
    assert(result.success);

    TradeLicenseDTO update;
    update.id = "LIC-10";
    update.status = "blocked";
    update.modifiedBy = "compliance";
    auto updateResult = uc.update(update);

    assert(updateResult.success);
    assert(repo.findAll()[0].status == ComplianceStatus.blocked);
}

@safe unittest {
    auto repo = new MemorySanctionedPartyCaseRepository();
    auto uc = new ManageSanctionedPartyCasesUseCase(repo);

    SanctionedPartyCaseDTO dto;
    dto.id = "SPL-7";
    dto.tenantId = "TEN-1";
    dto.partnerName = "Example Trading LLC";
    dto.matchCode = "MATCH-77";
    dto.risk = "high";
    dto.status = "draft";
    dto.createdBy = "screening";

    auto result = uc.create(dto);
    assert(result.success);

    auto removeResult = uc.remove("SPL-7");
    assert(removeResult.success);
    assert(repo.findAll().length == 0);
}
