module uim.platform.pp.infrastructure.container;

import uim.platform.pp;

@safe:

struct Container {
    AppConfig config;

    ManagePPObjectsUseCase manageUseCase;
    RunMRPUseCase runMRPUseCase;

    PPHealthController healthController;
    PPApiController apiController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    auto repository = new MemoryPPRepository();

    c.manageUseCase = new ManagePPObjectsUseCase(repository);
    c.runMRPUseCase = new RunMRPUseCase(c.manageUseCase);

    c.healthController = new PPHealthController();
    c.apiController = new PPApiController(c.manageUseCase, c.runMRPUseCase, config.webRoot);

    return c;
}
