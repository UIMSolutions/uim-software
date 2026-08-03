module uim.platform.material_traceability.presentation.http.controllers.mt_api;

import uim.platform.material_traceability;

@safe:

class MtApiController : SAPController {
    private UiController uiController;
    private TraceabilityApiController traceabilityApiController;
    private ObjectTypeController[] objectControllers;

    this(ManageMtObjectsUseCase manageUseCase, QueryMtEventsUseCase queryUseCase, string webRoot) {
        uiController = new UiController(webRoot);
        traceabilityApiController = new TraceabilityApiController(manageUseCase, queryUseCase);

        foreach (objectType; [
            MtBusinessObjectType.materials,
            MtBusinessObjectType.materialLots,
            MtBusinessObjectType.batches,
            MtBusinessObjectType.serialNumbers,
            MtBusinessObjectType.suppliers,
            MtBusinessObjectType.manufacturers,
            MtBusinessObjectType.plants,
            MtBusinessObjectType.warehouses,
            MtBusinessObjectType.shipmentUnits,
            MtBusinessObjectType.transportEvents,
            MtBusinessObjectType.transformationEvents,
            MtBusinessObjectType.consumptionEvents,
            MtBusinessObjectType.qualityInspections,
            MtBusinessObjectType.certificates,
            MtBusinessObjectType.complianceStatements,
            MtBusinessObjectType.recallCases,
            MtBusinessObjectType.incidents,
            MtBusinessObjectType.chainOfCustodyLinks,
            MtBusinessObjectType.lineageViews,
            MtBusinessObjectType.riskAssessments,
            MtBusinessObjectType.partnerMappings,
            MtBusinessObjectType.documentReferences,
            MtBusinessObjectType.apiDefinitions,
            MtBusinessObjectType.auditEntries
        ]) {
            objectControllers ~= new ObjectTypeController(manageUseCase, objectType);
        }
    }

    override void registerRoutes(URLRouter router) {
        uiController.registerRoutes(router);
        traceabilityApiController.registerRoutes(router);

        foreach (controller; objectControllers) {
            controller.registerRoutes(router);
        }
    }
}
