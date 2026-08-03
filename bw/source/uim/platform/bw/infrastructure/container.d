module uim.platform.bw.infrastructure.container;

import std.string : toLower;
import uim.platform.bw;

@safe:

struct Container {
    AppConfig config;

    ManageBwObjectsUseCase manageUseCase;
    QueryBwAssetsUseCase queryUseCase;

    BwHealthController healthController;
    BwApiController apiController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    BwRepository repository;
    switch (config.repositoryEngine.toLower()) {
    case "postgres":
        repository = new PostgresBwRepository(config.postgresUrl);
        break;
    case "mongo":
        repository = new MongoBwRepository(config.mongoUrl, config.mongoDatabase);
        break;
    default:
        repository = new MemoryBwRepository();
        break;
    }

    BwQueryRuntime queryRuntime;
    if (config.queryRuntimeUrl.length) {
        queryRuntime = new CurlRemoteBwQueryRuntime(
            config.queryRuntimeUrl,
            config.queryRuntimeBearerToken,
            config.queryRuntimeTimeoutSeconds
        );
    } else {
        queryRuntime = new SimulatedBwQueryRuntime();
    }

    c.manageUseCase = new ManageBwObjectsUseCase(repository);
    c.queryUseCase = new QueryBwAssetsUseCase(repository, queryRuntime);

    c.healthController = new BwHealthController();
    c.apiController = new BwApiController(c.manageUseCase, c.queryUseCase, config.webRoot);

    return c;
}
