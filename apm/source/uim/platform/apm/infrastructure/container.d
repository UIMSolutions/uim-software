module uim.platform.apm.infrastructure.container;

import uim.platform.apm;

@safe:

struct Container {
    AppConfig config;

    ManagePortfolioItemsUseCase managePortfolioItemsUseCase;
    ManageAssessmentsUseCase manageAssessmentsUseCase;
    AnalyzePortfolioUseCase analyzePortfolioUseCase;

    PortfolioItemsController portfolioItemsController;
    AssessmentsController assessmentsController;
    PortfolioAnalysisController portfolioAnalysisController;
    ApmHealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container container;
    container.config = config;

    auto portfolioItemRepo = new MemoryPortfolioItemRepository();
    auto assessmentRepo = new MemoryAssessmentRepository();

    container.managePortfolioItemsUseCase = new ManagePortfolioItemsUseCase(portfolioItemRepo);
    container.manageAssessmentsUseCase = new ManageAssessmentsUseCase(assessmentRepo, portfolioItemRepo);
    container.analyzePortfolioUseCase = new AnalyzePortfolioUseCase(portfolioItemRepo, assessmentRepo);

    container.portfolioItemsController = new PortfolioItemsController(container.managePortfolioItemsUseCase);
    container.assessmentsController = new AssessmentsController(container.manageAssessmentsUseCase);
    container.portfolioAnalysisController = new PortfolioAnalysisController(container.analyzePortfolioUseCase);
    container.healthController = new ApmHealthController();

    return container;
}
