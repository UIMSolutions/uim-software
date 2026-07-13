module uim.platform.verinice.infrastructure.container;

import uim.platform.verinice;

@safe:

struct Container {
    AppConfig config;

    ManageAssetsUseCase manageAssetsUseCase;
    ManageSafeguardsUseCase manageSafeguardsUseCase;
    ManageAssessmentsUseCase manageAssessmentsUseCase;
    RunVeriniceIntegrationsUseCase runVeriniceIntegrationsUseCase;

    AssetController assetController;
    SafeguardController safeguardController;
    AssessmentController assessmentController;
    IntegrationController integrationController;
    VeriniceHealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container container;
    container.config = config;

    auto assetRepo = new MemoryAssetRepository();
    auto safeguardRepo = new MemorySafeguardRepository();
    auto assessmentRepo = new MemoryAssessmentRepository();

    auto gsSyncGateway = new GsCatalogSyncStubGateway();

    container.manageAssetsUseCase = new ManageAssetsUseCase(assetRepo);
    container.manageSafeguardsUseCase = new ManageSafeguardsUseCase(safeguardRepo);
    container.manageAssessmentsUseCase = new ManageAssessmentsUseCase(assessmentRepo);
    container.runVeriniceIntegrationsUseCase = new RunVeriniceIntegrationsUseCase(safeguardRepo, gsSyncGateway);

    container.assetController = new AssetController(container.manageAssetsUseCase);
    container.safeguardController = new SafeguardController(container.manageSafeguardsUseCase);
    container.assessmentController = new AssessmentController(container.manageAssessmentsUseCase);
    container.integrationController = new IntegrationController(container.runVeriniceIntegrationsUseCase);
    container.healthController = new VeriniceHealthController();

    return container;
}
