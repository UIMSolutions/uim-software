module uim.platform.team.infrastructure.container;

import uim.platform.team;

@safe:

struct Container {
    AppConfig config;

    ManagePartsUseCase managePartsUseCase;
    ManageBomsUseCase manageBomsUseCase;
    ManageDocumentsUseCase manageDocumentsUseCase;
    ManageChangesUseCase manageChangesUseCase;
    AnalyzePlmUseCase analyzePlmUseCase;

    TeamHealthController healthController;
    PartsController partsController;
    BomController bomController;
    DocumentsController documentsController;
    ChangesController changesController;
    PlmAnalysisController plmAnalysisController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    auto partRepo = new MemoryPartRepository();
    auto bomRepo = new MemoryBomRepository();
    auto documentRepo = new MemoryDocumentRepository();
    auto changeRepo = new MemoryChangeRequestRepository();

    c.managePartsUseCase = new ManagePartsUseCase(partRepo);
    c.manageBomsUseCase = new ManageBomsUseCase(bomRepo, partRepo);
    c.manageDocumentsUseCase = new ManageDocumentsUseCase(documentRepo, partRepo);
    c.manageChangesUseCase = new ManageChangesUseCase(changeRepo, partRepo, documentRepo);
    c.analyzePlmUseCase = new AnalyzePlmUseCase(partRepo, bomRepo, documentRepo, changeRepo);

    c.healthController = new TeamHealthController();
    c.partsController = new PartsController(c.managePartsUseCase);
    c.bomController = new BomController(c.manageBomsUseCase);
    c.documentsController = new DocumentsController(c.manageDocumentsUseCase);
    c.changesController = new ChangesController(c.manageChangesUseCase);
    c.plmAnalysisController = new PlmAnalysisController(c.analyzePlmUseCase);

    return c;
}
