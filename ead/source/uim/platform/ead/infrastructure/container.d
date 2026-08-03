module uim.platform.ead.infrastructure.container;

import std.string : toLower;
import uim.platform.ead;

@safe:

struct Container {
    AppConfig config;

    ManageEadObjectsUseCase manageUseCase;
    QueryEadAssetsUseCase queryUseCase;

    EadHealthController healthController;
    EadApiController apiController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    EadRepository repository;
    switch (config.repositoryEngine.toLower()) {
    case "postgres":
        repository = new PostgresEadRepository(config.postgresUrl);
        break;
    case "mongo":
        repository = new MongoEadRepository(config.mongoUrl, config.mongoDatabase);
        break;
    default:
        repository = new MemoryEadRepository();
        break;
    }

    DiagramRuntime diagramRuntime;
    if (config.diagramRuntimeUrl.length) {
        diagramRuntime = new CurlRemoteDiagramRuntime(
            config.diagramRuntimeUrl,
            config.diagramRuntimeBearerToken,
            config.diagramRuntimeTimeoutSeconds
        );
    } else {
        diagramRuntime = new SimulatedDiagramRuntime();
    }

    c.manageUseCase = new ManageEadObjectsUseCase(repository);
    c.queryUseCase = new QueryEadAssetsUseCase(repository, diagramRuntime);

    c.healthController = new EadHealthController();
    c.apiController = new EadApiController(c.manageUseCase, c.queryUseCase, config.webRoot);

    return c;
}
