module uim.platform.ead.presentation.http.controllers.ead_api;

import uim.platform.ead;

@safe:

class EadApiController : SAPController {
    private UiController uiController;
    private QueryApiController queryApiController;
    private ObjectTypeController[] objectControllers;

    this(ManageEadObjectsUseCase manageUseCase, QueryEadAssetsUseCase queryUseCase, string webRoot) {
        uiController = new UiController(webRoot);
        queryApiController = new QueryApiController(manageUseCase, queryUseCase);

        foreach (objectType; [
            EadBusinessObjectType.businessCapabilities,
            EadBusinessObjectType.valueStreams,
            EadBusinessObjectType.businessProcesses,
            EadBusinessObjectType.processSteps,
            EadBusinessObjectType.businessServices,
            EadBusinessObjectType.organizationUnits,
            EadBusinessObjectType.roles,
            EadBusinessObjectType.informationObjects,
            EadBusinessObjectType.dataObjects,
            EadBusinessObjectType.applicationComponents,
            EadBusinessObjectType.applicationServices,
            EadBusinessObjectType.interfaces,
            EadBusinessObjectType.apiDefinitions,
            EadBusinessObjectType.integrationFlows,
            EadBusinessObjectType.technologyComponents,
            EadBusinessObjectType.technologyServices,
            EadBusinessObjectType.systems,
            EadBusinessObjectType.landscapes,
            EadBusinessObjectType.standards,
            EadBusinessObjectType.principles,
            EadBusinessObjectType.viewpoints,
            EadBusinessObjectType.diagrams,
            EadBusinessObjectType.dependencies,
            EadBusinessObjectType.roadmaps,
            EadBusinessObjectType.workPackages,
            EadBusinessObjectType.projects,
            EadBusinessObjectType.risks,
            EadBusinessObjectType.controls,
            EadBusinessObjectType.auditEntries
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
