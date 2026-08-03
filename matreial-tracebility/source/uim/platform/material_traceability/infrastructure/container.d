module uim.platform.material_traceability.infrastructure.container;

import std.string : toLower;
import uim.platform.material_traceability;

@safe:

struct Container {
    AppConfig config;

    ManageMtObjectsUseCase manageUseCase;
    QueryMtEventsUseCase queryUseCase;

    MtHealthController healthController;
    MtApiController apiController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    MtRepository repository;
    switch (config.repositoryEngine.toLower()) {
    case "postgres":
        repository = new PostgresMtRepository(config.postgresUrl);
        break;
    case "mongo":
        repository = new MongoMtRepository(config.mongoUrl, config.mongoDatabase);
        break;
    default:
        repository = new MemoryMtRepository();
        break;
    }

    c.manageUseCase = new ManageMtObjectsUseCase(repository);
    c.queryUseCase = new QueryMtEventsUseCase(repository);

    c.healthController = new MtHealthController();
    c.apiController = new MtApiController(c.manageUseCase, c.queryUseCase, config.webRoot);

    return c;
}
