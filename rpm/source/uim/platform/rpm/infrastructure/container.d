module uim.platform.rpm.infrastructure.container;

import std.string : toLower;
import uim.platform.rpm;

@safe:

struct Container {
    AppConfig config;

    ManageRpmObjectsUseCase manageUseCase;
    QueryRpmNetworkUseCase queryUseCase;
    ManageOperationsUseCase operationsUseCase;

    RpmHealthController healthController;
    RpmApiController apiController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    RpmRepository repository;
    switch (config.repositoryEngine.toLower()) {
    case "memory":
        repository = new MemoryRpmRepository();
        break;
    default:
        repository = new MemoryRpmRepository();
        break;
    }

    RpmAnalyticsRuntime analyticsRuntime = new SimulatedRpmAnalyticsRuntime();

    c.manageUseCase = new ManageRpmObjectsUseCase(repository);
    c.queryUseCase = new QueryRpmNetworkUseCase(repository, analyticsRuntime);
    c.operationsUseCase = new ManageOperationsUseCase(c.manageUseCase);

    c.healthController = new RpmHealthController();
    c.apiController = new RpmApiController(c.manageUseCase, c.queryUseCase, c.operationsUseCase, config.webRoot);

    return c;
}
