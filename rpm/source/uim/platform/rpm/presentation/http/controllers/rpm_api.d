module uim.platform.rpm.presentation.http.controllers.rpm_api;

import uim.platform.rpm;

@safe:

class RpmApiController : SAPController {
    private UiController uiController;
    private OperationsApiController operationsController;
    private ObjectTypeController[] objectControllers;

    this(
        ManageRpmObjectsUseCase manageUseCase,
        QueryRpmNetworkUseCase queryUseCase,
        ManageOperationsUseCase operationsUseCase,
        string webRoot
    ) {
        uiController = new UiController(webRoot);
        operationsController = new OperationsApiController(queryUseCase, operationsUseCase);

        foreach (objectType; [
            RpmBusinessObjectType.packagingMaterials,
            RpmBusinessObjectType.packagingPools,
            RpmBusinessObjectType.packagingOwners,
            RpmBusinessObjectType.partners,
            RpmBusinessObjectType.locations,
            RpmBusinessObjectType.depots,
            RpmBusinessObjectType.lanes,
            RpmBusinessObjectType.shipmentOrders,
            RpmBusinessObjectType.shipmentItems,
            RpmBusinessObjectType.returnOrders,
            RpmBusinessObjectType.returnItems,
            RpmBusinessObjectType.rentalContracts,
            RpmBusinessObjectType.qualityInspections,
            RpmBusinessObjectType.cleaningOrders,
            RpmBusinessObjectType.repairOrders,
            RpmBusinessObjectType.transferOrders,
            RpmBusinessObjectType.inventorySnapshots,
            RpmBusinessObjectType.cycleCounts,
            RpmBusinessObjectType.serialAssets,
            RpmBusinessObjectType.telemetryEvents,
            RpmBusinessObjectType.alerts,
            RpmBusinessObjectType.invoices,
            RpmBusinessObjectType.apiDefinitions,
            RpmBusinessObjectType.auditEntries
        ]) {
            objectControllers ~= new ObjectTypeController(manageUseCase, objectType);
        }
    }

    override void registerRoutes(URLRouter router) {
        uiController.registerRoutes(router);
        operationsController.registerRoutes(router);

        foreach (controller; objectControllers) {
            controller.registerRoutes(router);
        }
    }
}
