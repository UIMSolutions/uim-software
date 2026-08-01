module uim.platform.ecm.infrastructure.container;

import std.string : toLower;
import uim.platform.ecm;

@safe:

struct Container {
    AppConfig config;

    ManageEcmObjectsUseCase manageUseCase;
    QueryDocumentsUseCase queryDocumentsUseCase;

    EcmHealthController healthController;
    EcmApiController apiController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    EcmRepository repository;
    switch (config.repositoryEngine.toLower()) {
    case "postgres":
        repository = new PostgresEcmRepository(config.postgresUrl);
        break;
    case "mongo":
        repository = new MongoEcmRepository(config.mongoUrl, config.mongoDatabase);
        break;
    default:
        repository = new MemoryEcmRepository();
        break;
    }

    c.manageUseCase = new ManageEcmObjectsUseCase(repository);
    c.queryDocumentsUseCase = new QueryDocumentsUseCase(repository);

    c.healthController = new EcmHealthController();
    c.apiController = new EcmApiController(c.manageUseCase, c.queryDocumentsUseCase, config.webRoot);

    return c;
}
