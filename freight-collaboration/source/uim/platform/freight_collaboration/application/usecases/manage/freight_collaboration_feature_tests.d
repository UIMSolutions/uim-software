module uim.platform.freight_collaboration.application.usecases.manage.freight_collaboration_feature_tests;

import uim.platform.freight_collaboration;

@safe unittest {
    auto repo = new MemoryFreightOrderRepository();
    auto uc = new ManageFreightOrdersUseCase(repo);

    FreightOrderDTO dto;
    dto.id = "FO-100";
    dto.tenantId = "T1";
    dto.orderNumber = "45000023";
    dto.shipperId = "SHIP-01";
    dto.carrierId = "CAR-09";
    dto.transportMode = "road";
    dto.originLocation = "Berlin";
    dto.destinationLocation = "Hamburg";
    dto.createdBy = "seed";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].orderNumber == "45000023");
}

@safe unittest {
    auto repo = new MemoryTenderRepository();
    auto uc = new ManageTendersUseCase(repo);

    TenderDTO dto;
    dto.id = "TEN-100";
    dto.tenantId = "T1";
    dto.freightOrderId = "FO-100";
    dto.tenderNumber = "TND-2026-1";
    dto.offeredRate = "1200.00";
    dto.currency = "EUR";
    dto.createdBy = "seed";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].tenderNumber == "TND-2026-1");
}

@safe unittest {
    auto repo = new MemoryMilestoneRepository();
    auto uc = new ManageMilestonesUseCase(repo);

    MilestoneUpdateDTO dto;
    dto.id = "MS-100";
    dto.tenantId = "T1";
    dto.freightOrderId = "FO-100";
    dto.milestoneType = "departed-origin";
    dto.eventTime = "2026-07-15T09:00:00Z";
    dto.location = "Berlin";
    dto.createdBy = "seed";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].milestoneType == "departed-origin");
}
