module uim.platform.bw.presentation.http.controllers.bw_api;

import uim.platform.bw;

@safe:

class BwApiController : SAPController {
    private UiController uiController;
    private QueryApiController queryApiController;
    private ObjectTypeController[] objectControllers;

    this(ManageBwObjectsUseCase manageUseCase, QueryBwAssetsUseCase queryUseCase, string webRoot) {
        uiController = new UiController(webRoot);
        queryApiController = new QueryApiController(manageUseCase, queryUseCase);

        foreach (objectType; [
            BwBusinessObjectType.infoAreas,
            BwBusinessObjectType.infoObjects,
            BwBusinessObjectType.characteristics,
            BwBusinessObjectType.keyFigures,
            BwBusinessObjectType.hierarchies,
            BwBusinessObjectType.dataSources,
            BwBusinessObjectType.transformations,
            BwBusinessObjectType.dtrs,
            BwBusinessObjectType.adsos,
            BwBusinessObjectType.openHubDestinations,
            BwBusinessObjectType.compositeProviders,
            BwBusinessObjectType.cubes,
            BwBusinessObjectType.multiProviders,
            BwBusinessObjectType.queries,
            BwBusinessObjectType.workbooks,
            BwBusinessObjectType.processChains,
            BwBusinessObjectType.analysisAuthorizations,
            BwBusinessObjectType.planningModels,
            BwBusinessObjectType.aggregationLevels,
            BwBusinessObjectType.planningFunctions,
            BwBusinessObjectType.dataSlices,
            BwBusinessObjectType.dataFlows,
            BwBusinessObjectType.apiDefinitions,
            BwBusinessObjectType.auditEntries
        ]) {
            objectControllers ~= new ObjectTypeController(manageUseCase, objectType);
        }
    }

    override void registerRoutes(URLRouter router) {
        uiController.registerRoutes(router);
        queryApiController.registerRoutes(router);

        foreach (controller; objectControllers) {
            controller.registerRoutes(router);
        }
    }
}
