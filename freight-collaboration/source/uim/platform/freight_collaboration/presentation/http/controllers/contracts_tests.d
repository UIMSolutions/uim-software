module uim.platform.freight_collaboration.presentation.http.controllers.contracts_tests;

import vibe.http.router : URLRouter;
import uim.platform.freight_collaboration;

@safe unittest {
    auto router = new URLRouter();
    auto uc = new ManageFreightOrdersUseCase(new MemoryFreightOrderRepository());
    auto controller = new FreightOrderController(uc);
    controller.registerRoutes(router);
    assert(router !is null);
}

@safe unittest {
    auto router = new URLRouter();
    auto uc = new ManageTendersUseCase(new MemoryTenderRepository());
    auto controller = new TenderController(uc);
    controller.registerRoutes(router);
    assert(router !is null);
}

@safe unittest {
    auto router = new URLRouter();
    auto uc = new ManageMilestonesUseCase(new MemoryMilestoneRepository());
    auto controller = new MilestoneController(uc);
    controller.registerRoutes(router);
    assert(router !is null);
}

@safe unittest {
    auto router = new URLRouter();
    auto integrationUseCase = new RunFreightCollaborationIntegrationsUseCase(
        new MemoryTenderRepository(),
        new SapBnTenderSyncStubGateway()
    );
    auto integrationController = new IntegrationController(integrationUseCase);
    integrationController.registerRoutes(router);

    auto healthController = new FreightCollaborationHealthController();
    healthController.registerRoutes(router);
    assert(router !is null);
}
