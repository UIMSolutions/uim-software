module uim.platform.content.infrastructure.container;

import uim.platform.content;

@safe:

struct Container {
    AppConfig config;

    ManageContentRepositoriesUseCase manageContentRepositoriesUseCase;
    ManageFoldersUseCase manageFoldersUseCase;
    ManageDocumentsUseCase manageDocumentsUseCase;
    ManageDocumentVersionsUseCase manageDocumentVersionsUseCase;
    PushContentDocumentUseCase pushContentDocumentUseCase;

    ContentHealthController healthController;
    RepositoryController repositoryController;
    FolderController folderController;
    DocumentController documentController;
    DocumentVersionController versionController;
    IntegrationController integrationController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    auto repositoryRepo = new MemoryContentRepositoryRepository();
    auto folderRepo = new MemoryFolderRepository();
    auto documentRepo = new MemoryDocumentRepository();
    auto versionRepo = new MemoryDocumentVersionRepository();

    auto storageGateway = new ContentStorageStubGateway();

    c.manageContentRepositoriesUseCase = new ManageContentRepositoriesUseCase(repositoryRepo);
    c.manageFoldersUseCase = new ManageFoldersUseCase(folderRepo, repositoryRepo);
    c.manageDocumentsUseCase = new ManageDocumentsUseCase(documentRepo, folderRepo, repositoryRepo, versionRepo);
    c.manageDocumentVersionsUseCase = new ManageDocumentVersionsUseCase(versionRepo, documentRepo);
    c.pushContentDocumentUseCase = new PushContentDocumentUseCase(documentRepo, storageGateway);

    c.healthController = new ContentHealthController();
    c.repositoryController = new RepositoryController(c.manageContentRepositoriesUseCase);
    c.folderController = new FolderController(c.manageFoldersUseCase);
    c.documentController = new DocumentController(c.manageDocumentsUseCase);
    c.versionController = new DocumentVersionController(c.manageDocumentVersionsUseCase);
    c.integrationController = new IntegrationController(c.pushContentDocumentUseCase);

    return c;
}
