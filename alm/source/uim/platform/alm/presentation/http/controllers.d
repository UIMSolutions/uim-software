module uim.platform.alm.presentation.http.controllers;

import std.conv : to;

import uim.platform.alm.application;
import uim.platform.alm.presentation.http.json_utils;

@safe:

class ALMHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto payload = Json.emptyObject;
        payload["service"] = Json("Solution Lifecycle Service");
        payload["status"] = Json("ok");
        res.writeJsonBody(payload, 200);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto payload = Json.emptyObject;
        payload["status"] = Json("ok");
        res.writeJsonBody(payload, 200);
    }
}

class ALMApiController : SAPController {
    private ManageSolutionsUseCase solutions;
    private ManageDeliveryUseCase delivery;
    private ManageQualityUseCase quality;
    private ManageOperationsUseCase operations;
    private AnalyzeAlmUseCase analyzer;

    this(
        ManageSolutionsUseCase solutions,
        ManageDeliveryUseCase delivery,
        ManageQualityUseCase quality,
        ManageOperationsUseCase operations,
        AnalyzeAlmUseCase analyzer
    ) {
        this.solutions = solutions;
        this.delivery = delivery;
        this.quality = quality;
        this.operations = operations;
        this.analyzer = analyzer;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/alm/solutions", &handleSolutionsList);
        router.get("/api/v1/alm/solutions/*", &handleSolutionGet);
        router.post("/api/v1/alm/solutions", &handleSolutionCreate);
        router.put("/api/v1/alm/solutions/*", &handleSolutionUpdate);
        router.delete_("/api/v1/alm/solutions/*", &handleSolutionDelete);

        router.get("/api/v1/alm/projects", &handleProjectsList);
        router.get("/api/v1/alm/projects/*", &handleProjectGet);
        router.post("/api/v1/alm/projects", &handleProjectCreate);
        router.put("/api/v1/alm/projects/*", &handleProjectUpdate);
        router.delete_("/api/v1/alm/projects/*", &handleProjectDelete);

        router.get("/api/v1/alm/tasks", &handleTasksList);
        router.get("/api/v1/alm/tasks/*", &handleTaskGet);
        router.post("/api/v1/alm/tasks", &handleTaskCreate);
        router.put("/api/v1/alm/tasks/*", &handleTaskUpdate);
        router.delete_("/api/v1/alm/tasks/*", &handleTaskDelete);

        router.get("/api/v1/alm/test-plans", &handlePlansList);
        router.get("/api/v1/alm/test-plans/*", &handlePlanGet);
        router.post("/api/v1/alm/test-plans", &handlePlanCreate);
        router.put("/api/v1/alm/test-plans/*", &handlePlanUpdate);
        router.delete_("/api/v1/alm/test-plans/*", &handlePlanDelete);

        router.get("/api/v1/alm/test-cases", &handleCasesList);
        router.get("/api/v1/alm/test-cases/*", &handleCaseGet);
        router.post("/api/v1/alm/test-cases", &handleCaseCreate);
        router.put("/api/v1/alm/test-cases/*", &handleCaseUpdate);
        router.delete_("/api/v1/alm/test-cases/*", &handleCaseDelete);

        router.get("/api/v1/alm/defects", &handleDefectsList);
        router.get("/api/v1/alm/defects/*", &handleDefectGet);
        router.post("/api/v1/alm/defects", &handleDefectCreate);
        router.put("/api/v1/alm/defects/*", &handleDefectUpdate);
        router.delete_("/api/v1/alm/defects/*", &handleDefectDelete);

        router.get("/api/v1/alm/releases", &handleReleasesList);
        router.get("/api/v1/alm/releases/*", &handleReleaseGet);
        router.post("/api/v1/alm/releases", &handleReleaseCreate);
        router.put("/api/v1/alm/releases/*", &handleReleaseUpdate);
        router.delete_("/api/v1/alm/releases/*", &handleReleaseDelete);

        router.get("/api/v1/alm/deployments", &handleDeploymentsList);
        router.get("/api/v1/alm/deployments/*", &handleDeploymentGet);
        router.post("/api/v1/alm/deployments", &handleDeploymentCreate);
        router.put("/api/v1/alm/deployments/*", &handleDeploymentUpdate);
        router.delete_("/api/v1/alm/deployments/*", &handleDeploymentDelete);

        router.get("/api/v1/alm/environments", &handleEnvironmentsList);
        router.get("/api/v1/alm/environments/*", &handleEnvironmentGet);
        router.post("/api/v1/alm/environments", &handleEnvironmentCreate);
        router.put("/api/v1/alm/environments/*", &handleEnvironmentUpdate);
        router.delete_("/api/v1/alm/environments/*", &handleEnvironmentDelete);

        router.get("/api/v1/alm/alerts", &handleAlertsList);
        router.get("/api/v1/alm/alerts/*", &handleAlertGet);
        router.post("/api/v1/alm/alerts", &handleAlertCreate);
        router.put("/api/v1/alm/alerts/*", &handleAlertUpdate);
        router.delete_("/api/v1/alm/alerts/*", &handleAlertDelete);

        router.get("/api/v1/alm/summary", &handleSummary);
    }

    private string tenantId(scope HTTPServerRequest req) {
        return req.headers.get("X-Tenant-Id", "");
    }

    private Json jsonForList(T)(T[] items, Json delegate(T) mapper) {
        auto arr = Json.emptyArray;
        foreach (item; items)
            arr ~= mapper(item);
        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        return payload;
    }

    private void writeIdPayload(scope HTTPServerResponse res, string id, int status = 200) {
        auto payload = Json.emptyObject;
        payload["id"] = Json(id);
        res.writeJsonBody(payload, status);
    }

    private void handleSolutionsList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(solutions.listByTenant(tenantId(req)), &solutionToJson), 200);
    }

    private void handleSolutionGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = solutions.get_(extractIdFromPath(req.requestPath.to!string));
        if (item is null) {
            writeError(res, 404, "Solution not found");
            return;
        }
        res.writeJsonBody(solutionToJson(*item), 200);
    }

    private void handleSolutionCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        SolutionDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.owner = jsonStr(j, "owner");
        dto.businessCapability = jsonStr(j, "businessCapability");
        dto.stage = jsonStr(j, "stage");
        dto.riskLevel = jsonStr(j, "riskLevel");
        dto.portfolioTag = jsonStr(j, "portfolioTag");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = solutions.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }
        writeIdPayload(res, result.id, 201);
    }

    private void handleSolutionUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        SolutionDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.owner = jsonStr(j, "owner");
        dto.businessCapability = jsonStr(j, "businessCapability");
        dto.stage = jsonStr(j, "stage");
        dto.riskLevel = jsonStr(j, "riskLevel");
        dto.portfolioTag = jsonStr(j, "portfolioTag");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = solutions.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }
        writeIdPayload(res, result.id, 200);
    }

    private void handleSolutionDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = solutions.remove(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }
        writeIdPayload(res, result.id, 200);
    }

    private void handleProjectsList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(delivery.listProjects(tenantId(req)), &projectToJson), 200);
    }

    private void handleProjectGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = delivery.getProject(extractIdFromPath(req.requestPath.to!string));
        if (item is null) {
            writeError(res, 404, "Project not found");
            return;
        }
        res.writeJsonBody(projectToJson(*item), 200);
    }

    private void handleProjectCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        ProjectDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.solutionId = jsonStr(j, "solutionId");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.status = jsonStr(j, "status");
        dto.deliveryLead = jsonStr(j, "deliveryLead");
        dto.targetGoLiveDate = jsonStr(j, "targetGoLiveDate");
        dto.budgetHint = jsonStr(j, "budgetHint");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = delivery.createProject(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        writeIdPayload(res, result.id, 201);
    }

    private void handleProjectUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        ProjectDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.status = jsonStr(j, "status");
        dto.deliveryLead = jsonStr(j, "deliveryLead");
        dto.targetGoLiveDate = jsonStr(j, "targetGoLiveDate");
        dto.budgetHint = jsonStr(j, "budgetHint");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = delivery.updateProject(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleProjectDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = delivery.removeProject(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleTasksList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(delivery.listTasks(tenantId(req)), &taskToJson), 200);
    }

    private void handleTaskGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = delivery.getTask(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Task not found"); return; }
        res.writeJsonBody(taskToJson(*item), 200);
    }

    private void handleTaskCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        TaskDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.solutionId = jsonStr(j, "solutionId");
        dto.projectId = jsonStr(j, "projectId");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.status = jsonStr(j, "status");
        dto.assignee = jsonStr(j, "assignee");
        dto.dueDate = jsonStr(j, "dueDate");
        dto.dependencyTaskId = jsonStr(j, "dependencyTaskId");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = delivery.createTask(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        writeIdPayload(res, result.id, 201);
    }

    private void handleTaskUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        TaskDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.status = jsonStr(j, "status");
        dto.assignee = jsonStr(j, "assignee");
        dto.dueDate = jsonStr(j, "dueDate");
        dto.dependencyTaskId = jsonStr(j, "dependencyTaskId");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = delivery.updateTask(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleTaskDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = delivery.removeTask(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handlePlansList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(quality.listPlans(tenantId(req)), &testPlanToJson), 200);
    }

    private void handlePlanGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = quality.getPlan(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Test plan not found"); return; }
        res.writeJsonBody(testPlanToJson(*item), 200);
    }

    private void handlePlanCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        TestPlanDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.solutionId = jsonStr(j, "solutionId");
        dto.name = jsonStr(j, "name");
        dto.status = jsonStr(j, "status");
        dto.owner = jsonStr(j, "owner");
        dto.objective = jsonStr(j, "objective");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = quality.createPlan(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        writeIdPayload(res, result.id, 201);
    }

    private void handlePlanUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        TestPlanDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.status = jsonStr(j, "status");
        dto.owner = jsonStr(j, "owner");
        dto.objective = jsonStr(j, "objective");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = quality.updatePlan(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handlePlanDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = quality.removePlan(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleCasesList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(quality.listCases(tenantId(req)), &testCaseToJson), 200);
    }

    private void handleCaseGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = quality.getCase(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Test case not found"); return; }
        res.writeJsonBody(testCaseToJson(*item), 200);
    }

    private void handleCaseCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        TestCaseDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.planId = jsonStr(j, "planId");
        dto.name = jsonStr(j, "name");
        dto.status = jsonStr(j, "status");
        dto.automated = jsonBool(j, "automated");
        dto.priority = jsonStr(j, "priority");
        dto.requirementRef = jsonStr(j, "requirementRef");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = quality.createCase(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        writeIdPayload(res, result.id, 201);
    }

    private void handleCaseUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        TestCaseDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.status = jsonStr(j, "status");
        dto.priority = jsonStr(j, "priority");
        dto.requirementRef = jsonStr(j, "requirementRef");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = quality.updateCase(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleCaseDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = quality.removeCase(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleDefectsList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(quality.listDefects(tenantId(req)), &defectToJson), 200);
    }

    private void handleDefectGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = quality.getDefect(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Defect not found"); return; }
        res.writeJsonBody(defectToJson(*item), 200);
    }

    private void handleDefectCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        DefectDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.solutionId = jsonStr(j, "solutionId");
        dto.testCaseId = jsonStr(j, "testCaseId");
        dto.title = jsonStr(j, "title");
        dto.severity = jsonStr(j, "severity");
        dto.status = jsonStr(j, "status");
        dto.rootCause = jsonStr(j, "rootCause");
        dto.assignedTo = jsonStr(j, "assignedTo");
        dto.foundInEnvironment = jsonStr(j, "foundInEnvironment");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = quality.createDefect(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        writeIdPayload(res, result.id, 201);
    }

    private void handleDefectUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        DefectDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.title = jsonStr(j, "title");
        dto.severity = jsonStr(j, "severity");
        dto.status = jsonStr(j, "status");
        dto.rootCause = jsonStr(j, "rootCause");
        dto.assignedTo = jsonStr(j, "assignedTo");
        dto.foundInEnvironment = jsonStr(j, "foundInEnvironment");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = quality.updateDefect(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleDefectDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = quality.removeDefect(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleReleasesList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(operations.listReleases(tenantId(req)), &releaseToJson), 200);
    }

    private void handleReleaseGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = operations.getRelease(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Release not found"); return; }
        res.writeJsonBody(releaseToJson(*item), 200);
    }

    private void handleReleaseCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        ReleaseDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.solutionId = jsonStr(j, "solutionId");
        dto.releaseVersion = jsonStr(j, "releaseVersion");
        dto.status = jsonStr(j, "status");
        dto.releaseScope = jsonStr(j, "releaseScope");
        dto.plannedGoLiveDate = jsonStr(j, "plannedGoLiveDate");
        dto.actualGoLiveDate = jsonStr(j, "actualGoLiveDate");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = operations.createRelease(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        writeIdPayload(res, result.id, 201);
    }

    private void handleReleaseUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        ReleaseDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.releaseVersion = jsonStr(j, "releaseVersion");
        dto.status = jsonStr(j, "status");
        dto.releaseScope = jsonStr(j, "releaseScope");
        dto.plannedGoLiveDate = jsonStr(j, "plannedGoLiveDate");
        dto.actualGoLiveDate = jsonStr(j, "actualGoLiveDate");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = operations.updateRelease(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleReleaseDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = operations.removeRelease(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleDeploymentsList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(operations.listDeployments(tenantId(req)), &deploymentToJson), 200);
    }

    private void handleDeploymentGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = operations.getDeployment(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Deployment not found"); return; }
        res.writeJsonBody(deploymentToJson(*item), 200);
    }

    private void handleDeploymentCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        DeploymentDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.releaseId = jsonStr(j, "releaseId");
        dto.environmentId = jsonStr(j, "environmentId");
        dto.status = jsonStr(j, "status");
        dto.startedAt = jsonStr(j, "startedAt");
        dto.finishedAt = jsonStr(j, "finishedAt");
        dto.executedBy = jsonStr(j, "executedBy");
        dto.logUrl = jsonStr(j, "logUrl");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = operations.createDeployment(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        writeIdPayload(res, result.id, 201);
    }

    private void handleDeploymentUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        DeploymentDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.status = jsonStr(j, "status");
        dto.startedAt = jsonStr(j, "startedAt");
        dto.finishedAt = jsonStr(j, "finishedAt");
        dto.executedBy = jsonStr(j, "executedBy");
        dto.logUrl = jsonStr(j, "logUrl");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = operations.updateDeployment(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleDeploymentDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = operations.removeDeployment(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleEnvironmentsList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(operations.listEnvironments(tenantId(req)), &environmentToJson), 200);
    }

    private void handleEnvironmentGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = operations.getEnvironment(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Environment not found"); return; }
        res.writeJsonBody(environmentToJson(*item), 200);
    }

    private void handleEnvironmentCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        EnvironmentDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.solutionId = jsonStr(j, "solutionId");
        dto.name = jsonStr(j, "name");
        dto.environmentType = jsonStr(j, "environmentType");
        dto.region = jsonStr(j, "region");
        dto.purpose = jsonStr(j, "purpose");
        dto.active = jsonBool(j, "active", true);
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = operations.createEnvironment(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        writeIdPayload(res, result.id, 201);
    }

    private void handleEnvironmentUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        EnvironmentDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.environmentType = jsonStr(j, "environmentType");
        dto.region = jsonStr(j, "region");
        dto.purpose = jsonStr(j, "purpose");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = operations.updateEnvironment(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleEnvironmentDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = operations.removeEnvironment(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleAlertsList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(jsonForList(operations.listAlerts(tenantId(req)), &alertToJson), 200);
    }

    private void handleAlertGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = operations.getAlert(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Alert not found"); return; }
        res.writeJsonBody(alertToJson(*item), 200);
    }

    private void handleAlertCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        AlertDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantId(req);
        dto.solutionId = jsonStr(j, "solutionId");
        dto.source = jsonStr(j, "source");
        dto.severity = jsonStr(j, "severity");
        dto.status = jsonStr(j, "status");
        dto.summary = jsonStr(j, "summary");
        dto.raisedAt = jsonStr(j, "raisedAt");
        dto.acknowledgedBy = jsonStr(j, "acknowledgedBy");
        dto.resolvedAt = jsonStr(j, "resolvedAt");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = operations.createAlert(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        writeIdPayload(res, result.id, 201);
    }

    private void handleAlertUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = parseBody(req);
        AlertDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.source = jsonStr(j, "source");
        dto.severity = jsonStr(j, "severity");
        dto.status = jsonStr(j, "status");
        dto.summary = jsonStr(j, "summary");
        dto.raisedAt = jsonStr(j, "raisedAt");
        dto.acknowledgedBy = jsonStr(j, "acknowledgedBy");
        dto.resolvedAt = jsonStr(j, "resolvedAt");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = operations.updateAlert(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleAlertDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = operations.removeAlert(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeIdPayload(res, result.id, 200);
    }

    private void handleSummary(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.writeJsonBody(summaryToJson(analyzer.summarize(tenantId(req))), 200);
    }
}
