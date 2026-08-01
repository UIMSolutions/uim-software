module uim.platform.mm.infrastructure.container;

import uim.platform.mm;

struct Container {
    ManageMaterialsUseCase manageMaterialsUseCase;
    ManagePlantsUseCase managePlantsUseCase;
    ManageStorageLocationsUseCase manageStorageLocationsUseCase;
    ManageVendorsUseCase manageVendorsUseCase;
    ManagePurchasingInfoRecordsUseCase managePurchasingInfoRecordsUseCase;
    ManageProcurementUseCase manageProcurementUseCase;
    ManageInventoryUseCase manageInventoryUseCase;

    MasterDataController masterDataController;
    ProcurementController procurementController;
    InventoryController inventoryController;
    MmWebClientController webClientController;
    HealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container container;

    auto materialRepo = new MemoryMaterialRepository();
    auto plantRepo = new MemoryPlantRepository();
    auto storageRepo = new MemoryStorageLocationRepository();
    auto vendorRepo = new MemoryVendorRepository();
    auto infoRecordRepo = new MemoryPurchasingInfoRecordRepository();
    auto requisitionRepo = new MemoryPurchaseRequisitionRepository();
    auto orderRepo = new MemoryPurchaseOrderRepository();
    auto receiptRepo = new MemoryGoodsReceiptRepository();
    auto stockRepo = new MemoryStockItemRepository();

    container.manageMaterialsUseCase = new ManageMaterialsUseCase(materialRepo);
    container.managePlantsUseCase = new ManagePlantsUseCase(plantRepo);
    container.manageStorageLocationsUseCase = new ManageStorageLocationsUseCase(storageRepo);
    container.manageVendorsUseCase = new ManageVendorsUseCase(vendorRepo);
    container.managePurchasingInfoRecordsUseCase = new ManagePurchasingInfoRecordsUseCase(infoRecordRepo);
    container.manageProcurementUseCase = new ManageProcurementUseCase(requisitionRepo, orderRepo, vendorRepo, infoRecordRepo);
    container.manageInventoryUseCase = new ManageInventoryUseCase(receiptRepo, stockRepo, orderRepo);

    container.masterDataController = new MasterDataController(
        container.manageMaterialsUseCase,
        container.managePlantsUseCase,
        container.manageStorageLocationsUseCase,
        container.manageVendorsUseCase,
        container.managePurchasingInfoRecordsUseCase
    );
    container.procurementController = new ProcurementController(container.manageProcurementUseCase);
    container.inventoryController = new InventoryController(container.manageInventoryUseCase);
    container.webClientController = new MmWebClientController();
    container.healthController = new HealthController("mm", "1.0.0");

    return container;
}