module uim.platform.pp.presentation.http.controllers.pp_api;

import uim.platform.pp;

@safe:

class PPApiController : SAPController {
    private PPUIController uiController;
    private PPPlanningController planningController;
    private PPObjectTypeController[] objectControllers;

    this(ManagePPObjectsUseCase manageUseCase, RunMRPUseCase runMRPUseCase, string webRoot) {
        uiController = new PPUIController(webRoot);
        planningController = new PPPlanningController(manageUseCase, runMRPUseCase);

        objectControllers ~= new PPObjectTypeController(manageUseCase, "materials");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "plants");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "work-centers");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "production-versions");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "bills-of-material");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "routings");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "mrp-areas");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "demand-programs");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "planned-orders");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "production-orders");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "order-operations");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "confirmations");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "capacity-requirements");
        objectControllers ~= new PPObjectTypeController(manageUseCase, "mrp-runs");
    }

    override void registerRoutes(URLRouter router) {
        uiController.registerRoutes(router);
        planningController.registerRoutes(router);
        foreach (controller; objectControllers) {
            controller.registerRoutes(router);
        }
    }
}
