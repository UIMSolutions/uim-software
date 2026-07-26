module uim.platform.alm.application.usecases;

import std.conv : to;

import uim.platform.alm.application.dto;
import uim.platform.alm.domain;

@safe:

private string nextId(string prefix, size_t count) {
    return prefix ~ "-" ~ to!string(count + 1);
}

private void updateText(ref string target, string value) {
    if (value.length > 0)
        target = value;
}

private bool hasRequiredText(string value) {
    return value.length > 0;
}

class ManageSolutionsUseCase {
    private SolutionRepository repo;

    this(SolutionRepository repo) {
        this.repo = repo;
    }

    Solution[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Solution* get_(SolutionId id) {
        return repo.findById(id);
    }

    CommandResult create(SolutionDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.name))
            return CommandResult(false, "", "Tenant and solution name are required");

        Solution item;
        item.id = dto.id.length > 0 ? dto.id : nextId("solution", repo.findAll().length);
        item.tenantId = dto.tenantId;
        item.name = dto.name;
        item.description = dto.description;
        item.owner = dto.owner;
        item.businessCapability = dto.businessCapability;
        item.stage = AlmPolicy.parseLifecycleStage(dto.stage, item.stage);
        item.riskLevel = AlmPolicy.parseRiskLevel(dto.riskLevel, item.riskLevel);
        item.portfolioTag = dto.portfolioTag;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        repo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult update(SolutionDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Solution not found");

        updateText(existing.name, dto.name);
        updateText(existing.description, dto.description);
        updateText(existing.owner, dto.owner);
        updateText(existing.businessCapability, dto.businessCapability);
        updateText(existing.portfolioTag, dto.portfolioTag);
        if (dto.stage.length > 0) {
            auto next = AlmPolicy.parseLifecycleStage(dto.stage, existing.stage);
            if (!AlmPolicy.canAdvance(existing.stage, next))
                return CommandResult(false, "", "Invalid lifecycle transition");
            existing.stage = next;
        }
        if (dto.riskLevel.length > 0)
            existing.riskLevel = AlmPolicy.parseRiskLevel(dto.riskLevel, existing.riskLevel);
        updateText(existing.modifiedAt, dto.modifiedAt);

        repo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult remove(SolutionId id) {
        if (!repo.remove(id))
            return CommandResult(false, "", "Solution not found");
        return CommandResult(true, id, "");
    }
}

class ManageDeliveryUseCase {
    private SolutionRepository solutionRepo;
    private ProjectRepository projectRepo;
    private TaskRepository taskRepo;

    this(SolutionRepository solutionRepo, ProjectRepository projectRepo, TaskRepository taskRepo) {
        this.solutionRepo = solutionRepo;
        this.projectRepo = projectRepo;
        this.taskRepo = taskRepo;
    }

    Project[] listProjects(TenantId tenantId) {
        return projectRepo.findByTenant(tenantId);
    }

    Project* getProject(ProjectId id) {
        return projectRepo.findById(id);
    }

    Task[] listTasks(TenantId tenantId) {
        return taskRepo.findByTenant(tenantId);
    }

    Task* getTask(TaskId id) {
        return taskRepo.findById(id);
    }

    CommandResult createProject(ProjectDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.solutionId) || !hasRequiredText(dto.name))
            return CommandResult(false, "", "Tenant, solution and project name are required");
        if (solutionRepo.findById(dto.solutionId) is null)
            return CommandResult(false, "", "Solution not found");

        Project item;
        item.id = dto.id.length > 0 ? dto.id : nextId("project", projectRepo.findAll().length);
        item.tenantId = dto.tenantId;
        item.solutionId = dto.solutionId;
        item.name = dto.name;
        item.description = dto.description;
        item.status = AlmPolicy.parseProjectStatus(dto.status, item.status);
        item.deliveryLead = dto.deliveryLead;
        item.targetGoLiveDate = dto.targetGoLiveDate;
        item.budgetHint = dto.budgetHint;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        projectRepo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult updateProject(ProjectDTO dto) {
        auto existing = projectRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Project not found");

        updateText(existing.name, dto.name);
        updateText(existing.description, dto.description);
        if (dto.status.length > 0)
            existing.status = AlmPolicy.parseProjectStatus(dto.status, existing.status);
        updateText(existing.deliveryLead, dto.deliveryLead);
        updateText(existing.targetGoLiveDate, dto.targetGoLiveDate);
        updateText(existing.budgetHint, dto.budgetHint);
        updateText(existing.modifiedAt, dto.modifiedAt);

        projectRepo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult removeProject(ProjectId id) {
        if (!projectRepo.remove(id))
            return CommandResult(false, "", "Project not found");
        return CommandResult(true, id, "");
    }

    CommandResult createTask(TaskDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.solutionId) || !hasRequiredText(dto.title))
            return CommandResult(false, "", "Tenant, solution and task title are required");
        if (solutionRepo.findById(dto.solutionId) is null)
            return CommandResult(false, "", "Solution not found");
        if (dto.projectId.length > 0 && projectRepo.findById(dto.projectId) is null)
            return CommandResult(false, "", "Project not found");

        Task item;
        item.id = dto.id.length > 0 ? dto.id : nextId("task", taskRepo.findAll().length);
        item.tenantId = dto.tenantId;
        item.solutionId = dto.solutionId;
        item.projectId = dto.projectId;
        item.title = dto.title;
        item.description = dto.description;
        item.status = AlmPolicy.parseTaskStatus(dto.status, item.status);
        item.assignee = dto.assignee;
        item.dueDate = dto.dueDate;
        item.dependencyTaskId = dto.dependencyTaskId;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        taskRepo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult updateTask(TaskDTO dto) {
        auto existing = taskRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Task not found");

        updateText(existing.title, dto.title);
        updateText(existing.description, dto.description);
        if (dto.status.length > 0)
            existing.status = AlmPolicy.parseTaskStatus(dto.status, existing.status);
        updateText(existing.assignee, dto.assignee);
        updateText(existing.dueDate, dto.dueDate);
        updateText(existing.dependencyTaskId, dto.dependencyTaskId);
        updateText(existing.modifiedAt, dto.modifiedAt);

        taskRepo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult removeTask(TaskId id) {
        if (!taskRepo.remove(id))
            return CommandResult(false, "", "Task not found");
        return CommandResult(true, id, "");
    }
}

class ManageQualityUseCase {
    private SolutionRepository solutionRepo;
    private TestPlanRepository planRepo;
    private TestCaseRepository caseRepo;
    private DefectRepository defectRepo;

    this(
        SolutionRepository solutionRepo,
        TestPlanRepository planRepo,
        TestCaseRepository caseRepo,
        DefectRepository defectRepo
    ) {
        this.solutionRepo = solutionRepo;
        this.planRepo = planRepo;
        this.caseRepo = caseRepo;
        this.defectRepo = defectRepo;
    }

    TestPlan[] listPlans(TenantId tenantId) { return planRepo.findByTenant(tenantId); }
    TestPlan* getPlan(TestPlanId id) { return planRepo.findById(id); }
    TestCase[] listCases(TenantId tenantId) { return caseRepo.findByTenant(tenantId); }
    TestCase* getCase(TestCaseId id) { return caseRepo.findById(id); }
    Defect[] listDefects(TenantId tenantId) { return defectRepo.findByTenant(tenantId); }
    Defect* getDefect(DefectId id) { return defectRepo.findById(id); }

    CommandResult createPlan(TestPlanDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.solutionId) || !hasRequiredText(dto.name))
            return CommandResult(false, "", "Tenant, solution and test plan name are required");
        if (solutionRepo.findById(dto.solutionId) is null)
            return CommandResult(false, "", "Solution not found");

        TestPlan item;
        item.id = dto.id.length > 0 ? dto.id : nextId("test-plan", planRepo.findAll().length);
        item.tenantId = dto.tenantId;
        item.solutionId = dto.solutionId;
        item.name = dto.name;
        item.status = AlmPolicy.parseTestPlanStatus(dto.status, item.status);
        item.owner = dto.owner;
        item.objective = dto.objective;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        planRepo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult updatePlan(TestPlanDTO dto) {
        auto existing = planRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Test plan not found");

        updateText(existing.name, dto.name);
        if (dto.status.length > 0)
            existing.status = AlmPolicy.parseTestPlanStatus(dto.status, existing.status);
        updateText(existing.owner, dto.owner);
        updateText(existing.objective, dto.objective);
        updateText(existing.modifiedAt, dto.modifiedAt);

        planRepo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult removePlan(TestPlanId id) {
        if (!planRepo.remove(id))
            return CommandResult(false, "", "Test plan not found");
        return CommandResult(true, id, "");
    }

    CommandResult createCase(TestCaseDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.planId) || !hasRequiredText(dto.name))
            return CommandResult(false, "", "Tenant, plan and test case name are required");
        if (planRepo.findById(dto.planId) is null)
            return CommandResult(false, "", "Test plan not found");

        TestCase item;
        item.id = dto.id.length > 0 ? dto.id : nextId("test-case", caseRepo.findAll().length);
        item.tenantId = dto.tenantId;
        item.planId = dto.planId;
        item.name = dto.name;
        item.status = AlmPolicy.parseTestCaseStatus(dto.status, item.status);
        item.automated = dto.automated;
        item.priority = dto.priority;
        item.requirementRef = dto.requirementRef;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        caseRepo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult updateCase(TestCaseDTO dto) {
        auto existing = caseRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Test case not found");

        updateText(existing.name, dto.name);
        if (dto.status.length > 0)
            existing.status = AlmPolicy.parseTestCaseStatus(dto.status, existing.status);
        updateText(existing.priority, dto.priority);
        updateText(existing.requirementRef, dto.requirementRef);
        updateText(existing.modifiedAt, dto.modifiedAt);

        caseRepo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult removeCase(TestCaseId id) {
        if (!caseRepo.remove(id))
            return CommandResult(false, "", "Test case not found");
        return CommandResult(true, id, "");
    }

    CommandResult createDefect(DefectDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.solutionId) || !hasRequiredText(dto.title))
            return CommandResult(false, "", "Tenant, solution and defect title are required");
        if (solutionRepo.findById(dto.solutionId) is null)
            return CommandResult(false, "", "Solution not found");
        if (dto.testCaseId.length > 0 && caseRepo.findById(dto.testCaseId) is null)
            return CommandResult(false, "", "Test case not found");

        Defect item;
        item.id = dto.id.length > 0 ? dto.id : nextId("defect", defectRepo.findAll().length);
        item.tenantId = dto.tenantId;
        item.solutionId = dto.solutionId;
        item.testCaseId = dto.testCaseId;
        item.title = dto.title;
        item.severity = AlmPolicy.parseDefectSeverity(dto.severity, item.severity);
        item.status = AlmPolicy.parseDefectStatus(dto.status, item.status);
        item.rootCause = dto.rootCause;
        item.assignedTo = dto.assignedTo;
        item.foundInEnvironment = dto.foundInEnvironment;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        defectRepo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult updateDefect(DefectDTO dto) {
        auto existing = defectRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Defect not found");

        updateText(existing.title, dto.title);
        if (dto.severity.length > 0)
            existing.severity = AlmPolicy.parseDefectSeverity(dto.severity, existing.severity);
        if (dto.status.length > 0)
            existing.status = AlmPolicy.parseDefectStatus(dto.status, existing.status);
        updateText(existing.rootCause, dto.rootCause);
        updateText(existing.assignedTo, dto.assignedTo);
        updateText(existing.foundInEnvironment, dto.foundInEnvironment);
        updateText(existing.modifiedAt, dto.modifiedAt);

        defectRepo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult removeDefect(DefectId id) {
        if (!defectRepo.remove(id))
            return CommandResult(false, "", "Defect not found");
        return CommandResult(true, id, "");
    }
}

class ManageOperationsUseCase {
    private SolutionRepository solutionRepo;
    private ReleaseRepository releaseRepo;
    private DeploymentRepository deploymentRepo;
    private EnvironmentRepository environmentRepo;
    private AlertRepository alertRepo;

    this(
        SolutionRepository solutionRepo,
        ReleaseRepository releaseRepo,
        DeploymentRepository deploymentRepo,
        EnvironmentRepository environmentRepo,
        AlertRepository alertRepo
    ) {
        this.solutionRepo = solutionRepo;
        this.releaseRepo = releaseRepo;
        this.deploymentRepo = deploymentRepo;
        this.environmentRepo = environmentRepo;
        this.alertRepo = alertRepo;
    }

    Release[] listReleases(TenantId tenantId) { return releaseRepo.findByTenant(tenantId); }
    Release* getRelease(ReleaseId id) { return releaseRepo.findById(id); }
    Deployment[] listDeployments(TenantId tenantId) { return deploymentRepo.findByTenant(tenantId); }
    Deployment* getDeployment(DeploymentId id) { return deploymentRepo.findById(id); }
    Environment[] listEnvironments(TenantId tenantId) { return environmentRepo.findByTenant(tenantId); }
    Environment* getEnvironment(EnvironmentId id) { return environmentRepo.findById(id); }
    Alert[] listAlerts(TenantId tenantId) { return alertRepo.findByTenant(tenantId); }
    Alert* getAlert(AlertId id) { return alertRepo.findById(id); }

    CommandResult createRelease(ReleaseDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.solutionId) || !hasRequiredText(dto.releaseVersion))
            return CommandResult(false, "", "Tenant, solution and release version are required");
        if (solutionRepo.findById(dto.solutionId) is null)
            return CommandResult(false, "", "Solution not found");

        Release item;
        item.id = dto.id.length > 0 ? dto.id : nextId("release", releaseRepo.findAll().length);
        item.tenantId = dto.tenantId;
        item.solutionId = dto.solutionId;
        item.releaseVersion = dto.releaseVersion;
        item.status = AlmPolicy.parseReleaseStatus(dto.status, item.status);
        item.releaseScope = dto.releaseScope;
        item.plannedGoLiveDate = dto.plannedGoLiveDate;
        item.actualGoLiveDate = dto.actualGoLiveDate;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        releaseRepo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult updateRelease(ReleaseDTO dto) {
        auto existing = releaseRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Release not found");

        updateText(existing.releaseVersion, dto.releaseVersion);
        if (dto.status.length > 0)
            existing.status = AlmPolicy.parseReleaseStatus(dto.status, existing.status);
        updateText(existing.releaseScope, dto.releaseScope);
        updateText(existing.plannedGoLiveDate, dto.plannedGoLiveDate);
        updateText(existing.actualGoLiveDate, dto.actualGoLiveDate);
        updateText(existing.modifiedAt, dto.modifiedAt);

        releaseRepo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult removeRelease(ReleaseId id) {
        if (!releaseRepo.remove(id))
            return CommandResult(false, "", "Release not found");
        return CommandResult(true, id, "");
    }

    CommandResult createDeployment(DeploymentDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.releaseId) || !hasRequiredText(dto.environmentId))
            return CommandResult(false, "", "Tenant, release and environment are required");
        if (releaseRepo.findById(dto.releaseId) is null)
            return CommandResult(false, "", "Release not found");
        if (environmentRepo.findById(dto.environmentId) is null)
            return CommandResult(false, "", "Environment not found");

        Deployment item;
        item.id = dto.id.length > 0 ? dto.id : nextId("deployment", deploymentRepo.findAll().length);
        item.tenantId = dto.tenantId;
        item.releaseId = dto.releaseId;
        item.environmentId = dto.environmentId;
        item.status = AlmPolicy.parseDeploymentStatus(dto.status, item.status);
        item.startedAt = dto.startedAt;
        item.finishedAt = dto.finishedAt;
        item.executedBy = dto.executedBy;
        item.logUrl = dto.logUrl;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        deploymentRepo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult updateDeployment(DeploymentDTO dto) {
        auto existing = deploymentRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Deployment not found");

        if (dto.status.length > 0)
            existing.status = AlmPolicy.parseDeploymentStatus(dto.status, existing.status);
        updateText(existing.startedAt, dto.startedAt);
        updateText(existing.finishedAt, dto.finishedAt);
        updateText(existing.executedBy, dto.executedBy);
        updateText(existing.logUrl, dto.logUrl);
        updateText(existing.modifiedAt, dto.modifiedAt);

        deploymentRepo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult removeDeployment(DeploymentId id) {
        if (!deploymentRepo.remove(id))
            return CommandResult(false, "", "Deployment not found");
        return CommandResult(true, id, "");
    }

    CommandResult createEnvironment(EnvironmentDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.solutionId) || !hasRequiredText(dto.name))
            return CommandResult(false, "", "Tenant, solution and environment name are required");
        if (solutionRepo.findById(dto.solutionId) is null)
            return CommandResult(false, "", "Solution not found");

        Environment item;
        item.id = dto.id.length > 0 ? dto.id : nextId("environment", environmentRepo.findAll().length);
        item.tenantId = dto.tenantId;
        item.solutionId = dto.solutionId;
        item.name = dto.name;
        item.environmentType = AlmPolicy.parseEnvironmentType(dto.environmentType, item.environmentType);
        item.region = dto.region;
        item.purpose = dto.purpose;
        item.active = dto.active;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        environmentRepo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult updateEnvironment(EnvironmentDTO dto) {
        auto existing = environmentRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Environment not found");

        updateText(existing.name, dto.name);
        if (dto.environmentType.length > 0)
            existing.environmentType = AlmPolicy.parseEnvironmentType(dto.environmentType, existing.environmentType);
        updateText(existing.region, dto.region);
        updateText(existing.purpose, dto.purpose);
        updateText(existing.modifiedAt, dto.modifiedAt);

        environmentRepo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult removeEnvironment(EnvironmentId id) {
        if (!environmentRepo.remove(id))
            return CommandResult(false, "", "Environment not found");
        return CommandResult(true, id, "");
    }

    CommandResult createAlert(AlertDTO dto) {
        if (!hasRequiredText(dto.tenantId) || !hasRequiredText(dto.solutionId) || !hasRequiredText(dto.source))
            return CommandResult(false, "", "Tenant, solution and alert source are required");
        if (solutionRepo.findById(dto.solutionId) is null)
            return CommandResult(false, "", "Solution not found");

        Alert item;
        item.id = dto.id.length > 0 ? dto.id : nextId("alert", alertRepo.findAll().length);
        item.tenantId = dto.tenantId;
        item.solutionId = dto.solutionId;
        item.source = dto.source;
        item.severity = AlmPolicy.parseAlertSeverity(dto.severity, item.severity);
        item.status = AlmPolicy.parseAlertStatus(dto.status, item.status);
        item.summary = dto.summary;
        item.raisedAt = dto.raisedAt;
        item.acknowledgedBy = dto.acknowledgedBy;
        item.resolvedAt = dto.resolvedAt;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        alertRepo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult updateAlert(AlertDTO dto) {
        auto existing = alertRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Alert not found");

        updateText(existing.source, dto.source);
        if (dto.severity.length > 0)
            existing.severity = AlmPolicy.parseAlertSeverity(dto.severity, existing.severity);
        if (dto.status.length > 0)
            existing.status = AlmPolicy.parseAlertStatus(dto.status, existing.status);
        updateText(existing.summary, dto.summary);
        updateText(existing.raisedAt, dto.raisedAt);
        updateText(existing.acknowledgedBy, dto.acknowledgedBy);
        updateText(existing.resolvedAt, dto.resolvedAt);
        updateText(existing.modifiedAt, dto.modifiedAt);

        alertRepo.update(*existing);
        return CommandResult(true, existing.id, "");
    }

    CommandResult removeAlert(AlertId id) {
        if (!alertRepo.remove(id))
            return CommandResult(false, "", "Alert not found");
        return CommandResult(true, id, "");
    }
}

class AnalyzeAlmUseCase {
    private SolutionRepository solutionRepo;
    private ProjectRepository projectRepo;
    private TaskRepository taskRepo;
    private TestPlanRepository planRepo;
    private TestCaseRepository caseRepo;
    private DefectRepository defectRepo;
    private ReleaseRepository releaseRepo;
    private DeploymentRepository deploymentRepo;
    private AlertRepository alertRepo;

    this(
        SolutionRepository solutionRepo,
        ProjectRepository projectRepo,
        TaskRepository taskRepo,
        TestPlanRepository planRepo,
        TestCaseRepository caseRepo,
        DefectRepository defectRepo,
        ReleaseRepository releaseRepo,
        DeploymentRepository deploymentRepo,
        AlertRepository alertRepo
    ) {
        this.solutionRepo = solutionRepo;
        this.projectRepo = projectRepo;
        this.taskRepo = taskRepo;
        this.planRepo = planRepo;
        this.caseRepo = caseRepo;
        this.defectRepo = defectRepo;
        this.releaseRepo = releaseRepo;
        this.deploymentRepo = deploymentRepo;
        this.alertRepo = alertRepo;
    }

    AlmSummaryDTO summarize(TenantId tenantId) {
        auto solutions = solutionRepo.findByTenant(tenantId);
        auto projects = projectRepo.findByTenant(tenantId);
        auto tasks = taskRepo.findByTenant(tenantId);
        auto plans = planRepo.findByTenant(tenantId);
        auto cases = caseRepo.findByTenant(tenantId);
        auto defects = defectRepo.findByTenant(tenantId);
        auto releases = releaseRepo.findByTenant(tenantId);
        auto deployments = deploymentRepo.findByTenant(tenantId);
        auto alerts = alertRepo.findByTenant(tenantId);

        AlmSummaryDTO summary;
        summary.totalSolutions = cast(long) solutions.length;
        summary.totalProjects = cast(long) projects.length;
        summary.totalTasks = cast(long) tasks.length;

        foreach (task; tasks)
            if (task.status != TaskStatus.done && task.status != TaskStatus.cancelled)
                summary.openTasks++;

        summary.totalTestPlans = cast(long) plans.length;
        summary.totalTestCases = cast(long) cases.length;

        foreach (defect; defects)
            if (defect.severity == DefectSeverity.critical && defect.status != DefectStatus.closed)
                summary.criticalDefects++;

        summary.totalReleases = cast(long) releases.length;

        foreach (deployment; deployments)
            if (deployment.status == DeploymentStatus.running || deployment.status == DeploymentStatus.scheduled)
                summary.activeDeployments++;

        foreach (alert; alerts) {
            if (AlmPolicy.isOpenAlert(alert.status))
                summary.openAlerts++;
            if (alert.severity == AlertSeverity.critical)
                summary.criticalAlerts++;
        }

        auto scored = cast(long)(summary.totalSolutions * 20 + summary.totalProjects * 10 + summary.totalReleases * 10);
        auto penalties = cast(long)(summary.openTasks * 3 + summary.criticalDefects * 15 + summary.criticalAlerts * 10);
        auto readiness = scored - penalties;
        summary.readinessScore = readiness < 0 ? 0 : (readiness > 100 ? 100 : readiness);
        return summary;
    }
}

version(unittest) {
    unittest {
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

        SolutionDTO solutionDto;
        solutionDto.tenantId = "tenant-1";
        solutionDto.name = "Core Finance";
        solutionDto.stage = "design";
        auto solutionResult = solutions.create(solutionDto);
        assert(solutionResult.success);

        ProjectDTO projectDto;
        projectDto.tenantId = "tenant-1";
        projectDto.solutionId = solutionResult.id;
        projectDto.name = "Rollout";
        assert(delivery.createProject(projectDto).success);

        auto summary = analyzer.summarize("tenant-1");
        assert(summary.totalSolutions == 1);
        assert(summary.totalProjects == 1);
    }
}
