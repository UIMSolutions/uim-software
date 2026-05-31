module uim.platform.ibp.application.usecases.manage.epd_feature_tests;

import uim.platform.ibp;

@safe unittest {
    auto repo = new MemoryProductRepository();
    auto uc = new ManageProductsUseCase(repo);

    ProductDTO dto;
    dto.id = "P-100";
    dto.tenantId = "T1";
    dto.name = "Autonomous Drone";
    dto.productNumber = "DRN-100";
    dto.productType = "finished";
    dto.lifecycleStatus = "draft";
    dto.category = "Defense";
    dto.baseUnit = "EA";
    dto.createdBy = "seed";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].name == "Autonomous Drone");
}

@safe unittest {
    auto repo = new MemoryChangeRequestRepository();
    auto uc = new ManageChangeRequestsUseCase(repo);

    ChangeRequestDTO dto;
    dto.id = "CR-10";
    dto.tenantId = "T1";
    dto.demandPlanId = "P-100";
    dto.title = "Increase battery capacity";
    dto.description = "Raise endurance to 90 minutes";
    dto.priority = "high";
    dto.status = "submitted";
    dto.reason = "Operational requirement";
    dto.impact = "Medium";
    dto.requestedBy = "eng-1";
    dto.createdBy = "eng-1";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].title == "Increase battery capacity");
}

@safe unittest {
    auto repo = new MemoryProductStructureRepository();
    auto uc = new ManageProductStructuresUseCase(repo);

    ProductStructureDTO dto;
    dto.id = "PS-1";
    dto.tenantId = "T1";
    dto.demandPlanId = "P-100";
    dto.name = "Airframe Assembly";
    dto.nodeType = "assembly";
    dto.quantity = "1";
    dto.mandatory = "true";
    dto.createdBy = "planner";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].nodeType == "assembly");
}
