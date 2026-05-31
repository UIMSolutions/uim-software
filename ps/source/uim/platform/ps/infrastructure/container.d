module uim.platform.ps.infrastructure.container;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

struct Container {
    ManageProjectsUseCase manageProjectsUseCase;
    ManageWBSElementsUseCase manageWBSElementsUseCase;
    ManageNetworkActivitiesUseCase manageNetworkActivitiesUseCase;
    ManageMilestonesUseCase manageMilestonesUseCase;
    ManageProjectCostsUseCase manageProjectCostsUseCase;
    ManageProjectBudgetsUseCase manageProjectBudgetsUseCase;

    ProjectController projectController;
    WBSElementController wbsElementController;
    NetworkActivityController networkActivityController;
    MilestoneController milestoneController;
    ProjectCostController projectCostController;
    ProjectBudgetController projectBudgetController;
    HealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container c;

    auto projectRepo = new MemoryProjectRepository();
    auto wbsRepo = new MemoryWBSElementRepository();
    auto activityRepo = new MemoryNetworkActivityRepository();
    auto milestoneRepo = new MemoryMilestoneRepository();
    auto costRepo = new MemoryProjectCostRepository();
    auto budgetRepo = new MemoryProjectBudgetRepository();

    c.manageProjectsUseCase = new ManageProjectsUseCase(projectRepo);
    c.manageWBSElementsUseCase = new ManageWBSElementsUseCase(wbsRepo);
    c.manageNetworkActivitiesUseCase = new ManageNetworkActivitiesUseCase(activityRepo);
    c.manageMilestonesUseCase = new ManageMilestonesUseCase(milestoneRepo);
    c.manageProjectCostsUseCase = new ManageProjectCostsUseCase(costRepo);
    c.manageProjectBudgetsUseCase = new ManageProjectBudgetsUseCase(budgetRepo);

    c.projectController = new ProjectController(c.manageProjectsUseCase);
    c.wbsElementController = new WBSElementController(c.manageWBSElementsUseCase);
    c.networkActivityController = new NetworkActivityController(c.manageNetworkActivitiesUseCase);
    c.milestoneController = new MilestoneController(c.manageMilestonesUseCase);
    c.projectCostController = new ProjectCostController(c.manageProjectCostsUseCase);
    c.projectBudgetController = new ProjectBudgetController(c.manageProjectBudgetsUseCase);
    c.healthController = new HealthController();

    return c;
}
