module uim.platform.ppm.infrastructure.container;

import uim.platform.ppm;

@safe:

struct Container {
    AppConfig config;

    ManagePortfoliosUseCase managePortfoliosUseCase;
    ManageInitiativesUseCase manageInitiativesUseCase;
    ManageProgramsUseCase manageProgramsUseCase;
    ManageProjectsUseCase manageProjectsUseCase;
    ManageDemandsUseCase manageDemandsUseCase;
    ManageResourceRequestsUseCase manageResourceRequestsUseCase;

    PortfolioController portfolioController;
    InitiativeController initiativeController;
    ProgramController programController;
    ProjectController projectController;
    DemandController demandController;
    ResourceRequestController resourceRequestController;
    PpmHealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container container;
    container.config = config;

    PortfolioRepository portfolioRepo;
    InitiativeRepository initiativeRepo;
    ProgramRepository programRepo;
    ProjectRepository projectRepo;
    DemandRepository demandRepo;
    ResourceRequestRepository resourceRequestRepo;

    if (config.persistenceEngine == "postgres") {
        ensurePpmSchema(config.postgresUrl);
        portfolioRepo = new PostgresPortfolioRepository(config.postgresUrl);
        initiativeRepo = new PostgresInitiativeRepository(config.postgresUrl);
        programRepo = new PostgresProgramRepository(config.postgresUrl);
        projectRepo = new PostgresProjectRepository(config.postgresUrl);
        demandRepo = new PostgresDemandRepository(config.postgresUrl);
        resourceRequestRepo = new PostgresResourceRequestRepository(config.postgresUrl);
    } else {
        portfolioRepo = new MemoryPortfolioRepository();
        initiativeRepo = new MemoryInitiativeRepository();
        programRepo = new MemoryProgramRepository();
        projectRepo = new MemoryProjectRepository();
        demandRepo = new MemoryDemandRepository();
        resourceRequestRepo = new MemoryResourceRequestRepository();
    }

    container.managePortfoliosUseCase = new ManagePortfoliosUseCase(portfolioRepo);
    container.manageInitiativesUseCase = new ManageInitiativesUseCase(initiativeRepo);
    container.manageProgramsUseCase = new ManageProgramsUseCase(programRepo);
    container.manageProjectsUseCase = new ManageProjectsUseCase(projectRepo);
    container.manageDemandsUseCase = new ManageDemandsUseCase(demandRepo);
    container.manageResourceRequestsUseCase = new ManageResourceRequestsUseCase(resourceRequestRepo);

    container.portfolioController = new PortfolioController(container.managePortfoliosUseCase);
    container.initiativeController = new InitiativeController(container.manageInitiativesUseCase);
    container.programController = new ProgramController(container.manageProgramsUseCase);
    container.projectController = new ProjectController(container.manageProjectsUseCase);
    container.demandController = new DemandController(container.manageDemandsUseCase);
    container.resourceRequestController = new ResourceRequestController(container.manageResourceRequestsUseCase);
    container.healthController = new PpmHealthController();

    return container;
}
