/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ewm.infrastructure.container;

import uim.platform.ewm;

@safe:

struct Container {
    AppConfig config;

    ManageProductsUseCase manageProductsUseCase;
    ManageBillOfMaterialsUseCase manageBillOfMaterialsUseCase;
    ManageChangeRequestsUseCase manageChangeRequestsUseCase;
    ManageDocumentsUseCase manageDocumentsUseCase;
    ManageSpecificationsUseCase manageSpecificationsUseCase;
    ManageRecipesUseCase manageRecipesUseCase;
    ManageCollaborationsUseCase manageCollaborationsUseCase;
    ManageProductStructuresUseCase manageProductStructuresUseCase;
    RunEwmIntegrationsUseCase runEwmIntegrationsUseCase;

    ProductController productController;
    BillOfMaterialController billOfMaterialController;
    ChangeRequestController changeRequestController;
    DocumentController documentController;
    SpecificationController specificationController;
    RecipeController recipeController;
    CollaborationController collaborationController;
    ProductStructureController productStructureController;
    IntegrationController integrationController;
    EwmHealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container container;
    container.config = config;

    auto productRepo = new MemoryProductRepository();
    auto bomRepo = new MemoryBillOfMaterialRepository();
    auto changeRequestRepo = new MemoryChangeRequestRepository();
    auto documentRepo = new MemoryDocumentRepository();
    auto specificationRepo = new MemorySpecificationRepository();
    auto recipeRepo = new MemoryRecipeRepository();
    auto collaborationRepo = new MemoryCollaborationRepository();
    auto productStructureRepo = new MemoryProductStructureRepository();

    auto productHandoverGateway = new SapProductHandoverStubGateway();
    auto specificationSyncGateway = new SapSpecificationSyncStubGateway();

    container.manageProductsUseCase = new ManageProductsUseCase(productRepo);
    container.manageBillOfMaterialsUseCase = new ManageBillOfMaterialsUseCase(bomRepo);
    container.manageChangeRequestsUseCase = new ManageChangeRequestsUseCase(changeRequestRepo);
    container.manageDocumentsUseCase = new ManageDocumentsUseCase(documentRepo);
    container.manageSpecificationsUseCase = new ManageSpecificationsUseCase(specificationRepo);
    container.manageRecipesUseCase = new ManageRecipesUseCase(recipeRepo);
    container.manageCollaborationsUseCase = new ManageCollaborationsUseCase(collaborationRepo);
    container.manageProductStructuresUseCase = new ManageProductStructuresUseCase(productStructureRepo);
    container.runEwmIntegrationsUseCase = new RunEwmIntegrationsUseCase(
        productRepo,
        specificationRepo,
        productHandoverGateway,
        specificationSyncGateway
    );

    container.productController = new ProductController(container.manageProductsUseCase);
    container.billOfMaterialController = new BillOfMaterialController(container.manageBillOfMaterialsUseCase);
    container.changeRequestController = new ChangeRequestController(container.manageChangeRequestsUseCase);
    container.documentController = new DocumentController(container.manageDocumentsUseCase);
    container.specificationController = new SpecificationController(container.manageSpecificationsUseCase);
    container.recipeController = new RecipeController(container.manageRecipesUseCase);
    container.collaborationController = new CollaborationController(container.manageCollaborationsUseCase);
    container.productStructureController = new ProductStructureController(container.manageProductStructuresUseCase);
    container.integrationController = new IntegrationController(container.runEwmIntegrationsUseCase);
    container.healthController = new EwmHealthController();

    return container;
}
