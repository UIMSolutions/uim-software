module uim.platform.maif.infrastructure.container;

import uim.platform.maif;

@safe:

struct Container {
    AppConfig config;

    ManageMobileAppsUseCase manageMobileAppsUseCase;
    ManageIntegrationFlowsUseCase manageIntegrationFlowsUseCase;
    ManageSyncJobsUseCase manageSyncJobsUseCase;
    RunMaifIntegrationsUseCase runMaifIntegrationsUseCase;

    MaifHealthController healthController;
    MobileAppController mobileAppController;
    IntegrationFlowController integrationFlowController;
    SyncJobController syncJobController;
    IntegrationController integrationController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    auto mobileAppRepo = new MemoryMobileAppRepository();
    auto flowRepo = new MemoryIntegrationFlowRepository();
    auto syncJobRepo = new MemorySyncJobRepository();

    auto backendGateway = new MobileBackendStubGateway();

    c.manageMobileAppsUseCase = new ManageMobileAppsUseCase(mobileAppRepo);
    c.manageIntegrationFlowsUseCase = new ManageIntegrationFlowsUseCase(flowRepo);
    c.manageSyncJobsUseCase = new ManageSyncJobsUseCase(syncJobRepo);
    c.runMaifIntegrationsUseCase = new RunMaifIntegrationsUseCase(mobileAppRepo, backendGateway);

    c.healthController = new MaifHealthController();
    c.mobileAppController = new MobileAppController(c.manageMobileAppsUseCase);
    c.integrationFlowController = new IntegrationFlowController(c.manageIntegrationFlowsUseCase);
    c.syncJobController = new SyncJobController(c.manageSyncJobsUseCase);
    c.integrationController = new IntegrationController(c.runMaifIntegrationsUseCase);

    return c;
}
