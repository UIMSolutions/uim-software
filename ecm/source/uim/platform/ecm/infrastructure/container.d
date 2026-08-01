module uim.platform.ecm.infrastructure.container;

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

    auto repository = new MemoryEcmRepository();

    c.manageUseCase = new ManageEcmObjectsUseCase(repository);
    c.queryDocumentsUseCase = new QueryDocumentsUseCase(repository);

    c.healthController = new EcmHealthController();
    c.apiController = new EcmApiController(c.manageUseCase, c.queryDocumentsUseCase, config.webRoot);

    return c;
}
