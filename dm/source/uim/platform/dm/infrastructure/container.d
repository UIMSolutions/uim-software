module uim.platform.dm.infrastructure.container;

import uim.platform.dm;

@safe:

struct Container {
    AppConfig config;

    ManageProductionOrdersUseCase manageProductionOrdersUseCase;
    ManageOperationActivitiesUseCase manageOperationActivitiesUseCase;
    ManageWorkCentersUseCase manageWorkCentersUseCase;
    ManageResourcesUseCase manageResourcesUseCase;
    ManageMaterialsUseCase manageMaterialsUseCase;
    ManageShopFloorControlsUseCase manageShopFloorControlsUseCase;
    ManageWorkInstructionsUseCase manageWorkInstructionsUseCase;
    ManageQualityInspectionsUseCase manageQualityInspectionsUseCase;
    ManageNonconformancesUseCase manageNonconformancesUseCase;
    ManageGenealogyRecordsUseCase manageGenealogyRecordsUseCase;

    DMHealthController healthController;
    ProductionOrderController productionOrderController;
    OperationActivityController operationActivityController;
    DMWorkCenterController workCenterController;
    DMResourceController resourceController;
    DMMaterialController materialController;
    ShopFloorControlController shopFloorControlController;
    WorkInstructionController workInstructionController;
    QualityInspectionController qualityInspectionController;
    NonconformanceController nonconformanceController;
    GenealogyRecordController genealogyRecordController;
}

Container buildContainer(AppConfig config) {
    Container container;
    container.config = config;

    auto productionOrderRepo = new MemoryProductionOrderRepository();
    auto operationActivityRepo = new MemoryOperationActivityRepository();
    auto workCenterRepo = new MemoryWorkCenterRepository();
    auto resourceRepo = new MemoryResourceRepository();
    auto materialRepo = new MemoryMaterialRepository();
    auto shopFloorControlRepo = new MemoryShopFloorControlRepository();
    auto workInstructionRepo = new MemoryWorkInstructionRepository();
    auto qualityInspectionRepo = new MemoryQualityInspectionRepository();
    auto nonconformanceRepo = new MemoryNonconformanceRepository();
    auto genealogyRecordRepo = new MemoryGenealogyRecordRepository();

    container.manageProductionOrdersUseCase = new ManageProductionOrdersUseCase(productionOrderRepo);
    container.manageOperationActivitiesUseCase = new ManageOperationActivitiesUseCase(operationActivityRepo);
    container.manageWorkCentersUseCase = new ManageWorkCentersUseCase(workCenterRepo);
    container.manageResourcesUseCase = new ManageResourcesUseCase(resourceRepo);
    container.manageMaterialsUseCase = new ManageMaterialsUseCase(materialRepo);
    container.manageShopFloorControlsUseCase = new ManageShopFloorControlsUseCase(shopFloorControlRepo);
    container.manageWorkInstructionsUseCase = new ManageWorkInstructionsUseCase(workInstructionRepo);
    container.manageQualityInspectionsUseCase = new ManageQualityInspectionsUseCase(qualityInspectionRepo);
    container.manageNonconformancesUseCase = new ManageNonconformancesUseCase(nonconformanceRepo);
    container.manageGenealogyRecordsUseCase = new ManageGenealogyRecordsUseCase(genealogyRecordRepo);

    container.healthController = new DMHealthController();
    container.productionOrderController = new ProductionOrderController(container.manageProductionOrdersUseCase);
    container.operationActivityController = new OperationActivityController(container.manageOperationActivitiesUseCase);
    container.workCenterController = new DMWorkCenterController(container.manageWorkCentersUseCase);
    container.resourceController = new DMResourceController(container.manageResourcesUseCase);
    container.materialController = new DMMaterialController(container.manageMaterialsUseCase);
    container.shopFloorControlController = new ShopFloorControlController(container.manageShopFloorControlsUseCase);
    container.workInstructionController = new WorkInstructionController(container.manageWorkInstructionsUseCase);
    container.qualityInspectionController = new QualityInspectionController(container.manageQualityInspectionsUseCase);
    container.nonconformanceController = new NonconformanceController(container.manageNonconformancesUseCase);
    container.genealogyRecordController = new GenealogyRecordController(container.manageGenealogyRecordsUseCase);

    return container;
}
