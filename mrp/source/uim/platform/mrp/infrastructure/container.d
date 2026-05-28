module uim.platform.mrp.infrastructure.container;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct Container {
    ManageMaterialsUseCase manageMaterialsUseCase;
    ManagePlantsUseCase managePlantsUseCase;
    ManageBillsOfMaterialUseCase manageBillsOfMaterialUseCase;
    ManageInventoryPositionsUseCase manageInventoryPositionsUseCase;
    ManageMrpRunsUseCase manageMrpRunsUseCase;
    ManageProcurementProposalsUseCase manageProcurementProposalsUseCase;

    MaterialController materialController;
    PlantController plantController;
    BillOfMaterialController billOfMaterialController;
    InventoryPositionController inventoryPositionController;
    MrpRunController mrpRunController;
    ProcurementProposalController procurementProposalController;
    HealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container c;

    auto materialRepo = new MemoryMaterialRepository();
    auto plantRepo = new MemoryPlantRepository();
    auto bomRepo = new MemoryBillOfMaterialRepository();
    auto inventoryRepo = new MemoryInventoryPositionRepository();
    auto mrpRunRepo = new MemoryMrpRunRepository();
    auto proposalRepo = new MemoryProcurementProposalRepository();

    c.manageMaterialsUseCase = new ManageMaterialsUseCase(materialRepo);
    c.managePlantsUseCase = new ManagePlantsUseCase(plantRepo);
    c.manageBillsOfMaterialUseCase = new ManageBillsOfMaterialUseCase(bomRepo);
    c.manageInventoryPositionsUseCase = new ManageInventoryPositionsUseCase(inventoryRepo);
    c.manageMrpRunsUseCase = new ManageMrpRunsUseCase(mrpRunRepo, proposalRepo, materialRepo, bomRepo, inventoryRepo);
    c.manageProcurementProposalsUseCase = new ManageProcurementProposalsUseCase(proposalRepo);

    c.materialController = new MaterialController(c.manageMaterialsUseCase);
    c.plantController = new PlantController(c.managePlantsUseCase);
    c.billOfMaterialController = new BillOfMaterialController(c.manageBillsOfMaterialUseCase);
    c.inventoryPositionController = new InventoryPositionController(c.manageInventoryPositionsUseCase);
    c.mrpRunController = new MrpRunController(c.manageMrpRunsUseCase);
    c.procurementProposalController = new ProcurementProposalController(c.manageProcurementProposalsUseCase);
    c.healthController = new HealthController();

    return c;
}
