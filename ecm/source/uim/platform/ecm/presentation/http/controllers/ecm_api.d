module uim.platform.ecm.presentation.http.controllers.ecm_api;

import uim.platform.ecm;

@safe:

class EcmApiController : SAPController {
    private UiController uiController;
    private DocumentApiController documentApiController;
    private ObjectTypeController[] objectControllers;

    this(ManageEcmObjectsUseCase manageUseCase, QueryDocumentsUseCase queryUseCase, string webRoot) {
        uiController = new UiController(webRoot);
        documentApiController = new DocumentApiController(manageUseCase, queryUseCase);

        objectControllers ~= new ObjectTypeController(manageUseCase, "repositories");
        objectControllers ~= new ObjectTypeController(manageUseCase, "workspaces");
        objectControllers ~= new ObjectTypeController(manageUseCase, "folders");
        objectControllers ~= new ObjectTypeController(manageUseCase, "documents");
        objectControllers ~= new ObjectTypeController(manageUseCase, "document-versions");
        objectControllers ~= new ObjectTypeController(manageUseCase, "metadata-categories");
        objectControllers ~= new ObjectTypeController(manageUseCase, "users");
        objectControllers ~= new ObjectTypeController(manageUseCase, "groups");
        objectControllers ~= new ObjectTypeController(manageUseCase, "permissions");
        objectControllers ~= new ObjectTypeController(manageUseCase, "records");
        objectControllers ~= new ObjectTypeController(manageUseCase, "retention-policies");
        objectControllers ~= new ObjectTypeController(manageUseCase, "workflows");
        objectControllers ~= new ObjectTypeController(manageUseCase, "audit-entries");
    }

    override void registerRoutes(URLRouter router) {
        uiController.registerRoutes(router);
        documentApiController.registerRoutes(router);

        foreach (controller; objectControllers) {
            controller.registerRoutes(router);
        }
    }
}
