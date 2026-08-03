module uim.platform.npc.presentation.http.controllers.npc_api;

import uim.platform.npc;

@safe:

class NpcApiController : SAPController {
    private UiController uiController;
    private PlanApiController planApiController;
    private ObjectTypeController[] objectControllers;

    this(ManageNpcObjectsUseCase manageUseCase, QueryNpcPlansUseCase queryUseCase, string webRoot) {
        uiController = new UiController(webRoot);
        planApiController = new PlanApiController(manageUseCase, queryUseCase);

        foreach (objectType; [
            NpcBusinessObjectType.organizations,
            NpcBusinessObjectType.suppliers,
            NpcBusinessObjectType.customers,
            NpcBusinessObjectType.products,
            NpcBusinessObjectType.locations,
            NpcBusinessObjectType.resources,
            NpcBusinessObjectType.capacities,
            NpcBusinessObjectType.demandPlans,
            NpcBusinessObjectType.supplyPlans,
            NpcBusinessObjectType.constrainedPlans,
            NpcBusinessObjectType.scenarios,
            NpcBusinessObjectType.assumptions,
            NpcBusinessObjectType.milestones,
            NpcBusinessObjectType.exceptions,
            NpcBusinessObjectType.alerts,
            NpcBusinessObjectType.commitments,
            NpcBusinessObjectType.allocations,
            NpcBusinessObjectType.collaborationThreads,
            NpcBusinessObjectType.comments,
            NpcBusinessObjectType.attachments,
            NpcBusinessObjectType.workflows,
            NpcBusinessObjectType.approvals,
            NpcBusinessObjectType.kpiDefinitions,
            NpcBusinessObjectType.kpiValues,
            NpcBusinessObjectType.apiDefinitions,
            NpcBusinessObjectType.auditEntries
        ]) {
            objectControllers ~= new ObjectTypeController(manageUseCase, objectType);
        }
    }

    override void registerRoutes(URLRouter router) {
        uiController.registerRoutes(router);
        planApiController.registerRoutes(router);

        foreach (controller; objectControllers) {
            controller.registerRoutes(router);
        }
    }
}
