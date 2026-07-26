module uim.platform.alm.infrastructure.container;

import uim.platform.alm;

@safe:

struct Container {
    AppConfig config;

    ALMHealthController healthController;
    ALMApiController apiController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    auto solutionRepo = new MemoryCrudRepository!(Solution, SolutionId, solutionId, setSolutionId)();
    auto projectRepo = new MemoryCrudRepository!(Project, ProjectId, projectId, setProjectId)();
    auto taskRepo = new MemoryCrudRepository!(Task, TaskId, taskId, setTaskId)();
    auto planRepo = new MemoryCrudRepository!(TestPlan, TestPlanId, testPlanId, setTestPlanId)();
    auto caseRepo = new MemoryCrudRepository!(TestCase, TestCaseId, testCaseId, setTestCaseId)();
    auto defectRepo = new MemoryCrudRepository!(Defect, DefectId, defectId, setDefectId)();
    auto releaseRepo = new MemoryCrudRepository!(Release, ReleaseId, releaseId, setReleaseId)();
    auto deploymentRepo = new MemoryCrudRepository!(Deployment, DeploymentId, deploymentId, setDeploymentId)();
    auto environmentRepo = new MemoryCrudRepository!(Environment, EnvironmentId, environmentId, setEnvironmentId)();
    auto alertRepo = new MemoryCrudRepository!(Alert, AlertId, alertId, setAlertId)();

    auto solutions = new ManageSolutionsUseCase(solutionRepo);
    auto delivery = new ManageDeliveryUseCase(solutionRepo, projectRepo, taskRepo);
    auto quality = new ManageQualityUseCase(solutionRepo, planRepo, caseRepo, defectRepo);
    auto operations = new ManageOperationsUseCase(
        solutionRepo,
        releaseRepo,
        deploymentRepo,
        environmentRepo,
        alertRepo
    );
    auto analyzer = new AnalyzeAlmUseCase(
        solutionRepo,
        projectRepo,
        taskRepo,
        planRepo,
        caseRepo,
        defectRepo,
        releaseRepo,
        deploymentRepo,
        alertRepo
    );

    c.healthController = new ALMHealthController();
    c.apiController = new ALMApiController(solutions, delivery, quality, operations, analyzer);

    return c;
}
