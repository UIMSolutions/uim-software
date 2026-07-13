module uim.platform.freight_collaboration.infrastructure.container;

import uim.platform.freight_collaboration;

@safe:

struct Container {
    AppConfig config;

    ManageFreightOrdersUseCase manageFreightOrdersUseCase;
    ManageTendersUseCase manageTendersUseCase;
    ManageMilestonesUseCase manageMilestonesUseCase;
    RunFreightCollaborationIntegrationsUseCase runFreightCollaborationIntegrationsUseCase;

    FreightOrderController freightOrderController;
    TenderController tenderController;
    MilestoneController milestoneController;
    IntegrationController integrationController;
    FreightCollaborationHealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container container;
    container.config = config;

    auto freightOrderRepo = new MemoryFreightOrderRepository();
    auto tenderRepo = new MemoryTenderRepository();
    auto milestoneRepo = new MemoryMilestoneRepository();

    TenderSyncGateway tenderSyncGateway;
    if (config.useStubIntegration) {
        tenderSyncGateway = new SapBnTenderSyncStubGateway();
    } else {
        tenderSyncGateway = new SapBnTenderSyncHttpGateway(
            config.sapBnBaseUrl,
            config.sapBnTenderSyncPath,
            config.sapBnApiToken
        );
    }

    container.manageFreightOrdersUseCase = new ManageFreightOrdersUseCase(freightOrderRepo);
    container.manageTendersUseCase = new ManageTendersUseCase(tenderRepo);
    container.manageMilestonesUseCase = new ManageMilestonesUseCase(milestoneRepo);
    container.runFreightCollaborationIntegrationsUseCase =
        new RunFreightCollaborationIntegrationsUseCase(tenderRepo, tenderSyncGateway);

    container.freightOrderController = new FreightOrderController(container.manageFreightOrdersUseCase);
    container.tenderController = new TenderController(container.manageTendersUseCase);
    container.milestoneController = new MilestoneController(container.manageMilestonesUseCase);
    container.integrationController =
        new IntegrationController(container.runFreightCollaborationIntegrationsUseCase);
    container.healthController = new FreightCollaborationHealthController();

    return container;
}
