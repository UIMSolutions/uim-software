module uim.platform.npc.infrastructure.container;

import std.string : toLower;
import uim.platform.npc;

@safe:

struct Container {
    AppConfig config;

    ManageNpcObjectsUseCase manageUseCase;
    QueryNpcPlansUseCase queryUseCase;

    NpcHealthController healthController;
    NpcApiController apiController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    NpcRepository repository;
    switch (config.repositoryEngine.toLower()) {
    case "postgres":
        repository = new PostgresNpcRepository(config.postgresUrl);
        break;
    case "mongo":
        repository = new MongoNpcRepository(config.mongoUrl, config.mongoDatabase);
        break;
    default:
        repository = new MemoryNpcRepository();
        break;
    }

    c.manageUseCase = new ManageNpcObjectsUseCase(repository);
    c.queryUseCase = new QueryNpcPlansUseCase(repository);

    c.healthController = new NpcHealthController();
    c.apiController = new NpcApiController(c.manageUseCase, c.queryUseCase, config.webRoot);

    return c;
}
