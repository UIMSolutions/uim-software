module uim.platform.workflow.presentation.http.controllers.workflow_data;

import std.conv : to;
import std.string : toLower;

import uim.platform.workflow;

@safe:

private Json listResponse(T)(T[] values, Json function(ref T) @safe serializer) {
    auto resources = Json.emptyArray;
    foreach (ref value; values)
        resources ~= serializer(value);

    auto body = Json.emptyObject;
    body["count"] = Json(cast(long) values.length);
    body["resources"] = resources;
    return body;
}

private bool jsonBool(in Json j, string key, bool fallback = false) {
    if ((key in j) is null)
        return fallback;

    try return j[key].get!bool;
    catch (Exception ex) return jsonStr(j, key).toLower() == "true";
}

private string jsonStrAny(in Json j, string[] keys) {
    foreach (key; keys) {
        auto value = jsonStr(j, key);
        if (value.length > 0)
            return value;
    }
    return "";
}

private bool jsonBoolAny(in Json j, string[] keys, bool fallback = false) {
    foreach (key; keys)
        if ((key in j) !is null)
            return jsonBool(j, key, fallback);
    return fallback;
}

class WorkflowDefinitionController : SAPController {
    private ManageWorkflowDataUseCase uc;

    this(ManageWorkflowDataUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/workflow/definitions", &handleList);
        router.get("/api/v1/workflow/definitions/*", &handleGet);
        router.post("/api/v1/workflow/definitions", &handleCreate);
        router.put("/api/v1/workflow/definitions/*", &handleUpdate);
        router.delete_("/api/v1/workflow/definitions/*", &handleDelete);
        router.get("/api/v1/sap-advanced-workflow/workflow-definitions", &handleList);
        router.get("/api/v1/sap-advanced-workflow/workflow-definitions/*", &handleGet);
        router.post("/api/v1/sap-advanced-workflow/workflow-definitions", &handleCreate);
        router.put("/api/v1/sap-advanced-workflow/workflow-definitions/*", &handleUpdate);
        router.delete_("/api/v1/sap-advanced-workflow/workflow-definitions/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.listDefinitions(), &workflowDefinitionToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.getDefinition(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Workflow definition not found"); return; }
            res.writeJsonBody(workflowDefinitionToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowDefinitionDTO dto;
            dto.id = jsonStrAny(j, ["id", "workflowDefinitionId"]);
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStrAny(j, ["name", "workflowDefinitionName"]);
            dto.category = jsonStrAny(j, ["category", "workflowScenario"]);
            dto.starterRole = jsonStrAny(j, ["starterRole", "initiatedByRole"]);
            dto.priority = jsonStrAny(j, ["priority", "workflowPriority"]);
            dto.status = jsonStrAny(j, ["status", "lifecycleStatus"]);
            dto.createdBy = jsonStrAny(j, ["createdBy", "initiatedBy"]);

            auto result = uc.createDefinition(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow definition created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowDefinitionDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStrAny(j, ["name", "workflowDefinitionName"]);
            dto.category = jsonStrAny(j, ["category", "workflowScenario"]);
            dto.starterRole = jsonStrAny(j, ["starterRole", "initiatedByRole"]);
            dto.priority = jsonStrAny(j, ["priority", "workflowPriority"]);
            dto.status = jsonStrAny(j, ["status", "lifecycleStatus"]);
            dto.modifiedBy = jsonStrAny(j, ["modifiedBy", "changedBy"]);

            auto result = uc.updateDefinition(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow definition updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.removeDefinition(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Workflow definition deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class WorkflowInstanceController : SAPController {
    private ManageWorkflowDataUseCase uc;

    this(ManageWorkflowDataUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/workflow/instances", &handleList);
        router.get("/api/v1/workflow/instances/*", &handleGet);
        router.post("/api/v1/workflow/instances", &handleCreate);
        router.put("/api/v1/workflow/instances/*", &handleUpdate);
        router.delete_("/api/v1/workflow/instances/*", &handleDelete);
        router.get("/api/v1/sap-advanced-workflow/workflow-instances", &handleList);
        router.get("/api/v1/sap-advanced-workflow/workflow-instances/*", &handleGet);
        router.post("/api/v1/sap-advanced-workflow/workflow-instances", &handleCreate);
        router.put("/api/v1/sap-advanced-workflow/workflow-instances/*", &handleUpdate);
        router.delete_("/api/v1/sap-advanced-workflow/workflow-instances/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.listInstances(), &workflowInstanceToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.getInstance(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Workflow instance not found"); return; }
            res.writeJsonBody(workflowInstanceToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowInstanceDTO dto;
            dto.id = jsonStrAny(j, ["id", "workflowInstanceId"]);
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.definitionId = jsonStrAny(j, ["definitionId", "workflowDefinitionId"]);
            dto.businessObjectType = jsonStrAny(j, ["businessObjectType", "businessContextType"]);
            dto.businessObjectId = jsonStrAny(j, ["businessObjectId", "businessContextId"]);
            dto.status = jsonStrAny(j, ["status", "lifecycleStatus"]);
            dto.startedBy = jsonStrAny(j, ["startedBy", "initiatedBy"]);
            dto.startedAt = jsonStrAny(j, ["startedAt", "initiatedAt"]);
            dto.completedAt = jsonStrAny(j, ["completedAt", "finishedAt"]);

            auto result = uc.createInstance(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow instance created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowInstanceDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.status = jsonStrAny(j, ["status", "lifecycleStatus"]);
            dto.completedAt = jsonStrAny(j, ["completedAt", "finishedAt"]);
            dto.modifiedBy = jsonStrAny(j, ["modifiedBy", "changedBy"]);

            auto result = uc.updateInstance(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow instance updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.removeInstance(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Workflow instance deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class WorkflowTaskController : SAPController {
    private ManageWorkflowDataUseCase uc;

    this(ManageWorkflowDataUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/workflow/tasks", &handleList);
        router.get("/api/v1/workflow/tasks/*", &handleGet);
        router.post("/api/v1/workflow/tasks", &handleCreate);
        router.put("/api/v1/workflow/tasks/*", &handleUpdate);
        router.delete_("/api/v1/workflow/tasks/*", &handleDelete);
        router.get("/api/v1/sap-advanced-workflow/workflow-tasks", &handleList);
        router.get("/api/v1/sap-advanced-workflow/workflow-tasks/*", &handleGet);
        router.post("/api/v1/sap-advanced-workflow/workflow-tasks", &handleCreate);
        router.put("/api/v1/sap-advanced-workflow/workflow-tasks/*", &handleUpdate);
        router.delete_("/api/v1/sap-advanced-workflow/workflow-tasks/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.listTasks(), &workflowTaskToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.getTask(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Workflow task not found"); return; }
            res.writeJsonBody(workflowTaskToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowTaskDTO dto;
            dto.id = jsonStrAny(j, ["id", "workflowTaskId"]);
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.instanceId = jsonStrAny(j, ["instanceId", "workflowInstanceId"]);
            dto.title = jsonStrAny(j, ["title", "taskTitle"]);
            dto.assignee = jsonStrAny(j, ["assignee", "processor"]);
            dto.dueDate = jsonStrAny(j, ["dueDate", "latestEndDate"]);
            dto.priority = jsonStrAny(j, ["priority", "taskPriority"]);
            dto.state = jsonStrAny(j, ["state", "taskState"]);

            auto result = uc.createTask(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow task created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowTaskDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.assignee = jsonStrAny(j, ["assignee", "processor"]);
            dto.dueDate = jsonStrAny(j, ["dueDate", "latestEndDate"]);
            dto.priority = jsonStrAny(j, ["priority", "taskPriority"]);
            dto.state = jsonStrAny(j, ["state", "taskState"]);
            dto.completedBy = jsonStrAny(j, ["completedBy", "processedBy"]);
            dto.completedAt = jsonStrAny(j, ["completedAt", "processedAt"]);
            dto.modifiedBy = jsonStrAny(j, ["modifiedBy", "changedBy"]);

            auto result = uc.updateTask(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow task updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.removeTask(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Workflow task deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class ApprovalDecisionController : SAPController {
    private ManageWorkflowDataUseCase uc;

    this(ManageWorkflowDataUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/workflow/decisions", &handleList);
        router.get("/api/v1/workflow/decisions/*", &handleGet);
        router.post("/api/v1/workflow/decisions", &handleCreate);
        router.put("/api/v1/workflow/decisions/*", &handleUpdate);
        router.delete_("/api/v1/workflow/decisions/*", &handleDelete);
        router.get("/api/v1/sap-advanced-workflow/approval-decisions", &handleList);
        router.get("/api/v1/sap-advanced-workflow/approval-decisions/*", &handleGet);
        router.post("/api/v1/sap-advanced-workflow/approval-decisions", &handleCreate);
        router.put("/api/v1/sap-advanced-workflow/approval-decisions/*", &handleUpdate);
        router.delete_("/api/v1/sap-advanced-workflow/approval-decisions/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.listDecisions(), &approvalDecisionToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.getDecision(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Approval decision not found"); return; }
            res.writeJsonBody(approvalDecisionToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ApprovalDecisionDTO dto;
            dto.id = jsonStrAny(j, ["id", "workflowDecisionId"]);
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.taskId = jsonStrAny(j, ["taskId", "workflowTaskId"]);
            dto.decision = jsonStrAny(j, ["decision", "decisionType"]);
            dto.comment = jsonStrAny(j, ["comment", "decisionComment"]);
            dto.decidedBy = jsonStrAny(j, ["decidedBy", "approver"]);
            dto.decidedAt = jsonStrAny(j, ["decidedAt", "approvalDate"]);

            auto result = uc.createDecision(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Approval decision created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ApprovalDecisionDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.decision = jsonStrAny(j, ["decision", "decisionType"]);
            dto.comment = jsonStrAny(j, ["comment", "decisionComment"]);
            dto.decidedBy = jsonStrAny(j, ["decidedBy", "approver"]);
            dto.decidedAt = jsonStrAny(j, ["decidedAt", "approvalDate"]);

            auto result = uc.updateDecision(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Approval decision updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.removeDecision(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Approval decision deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class DeadlineEscalationController : SAPController {
    private ManageWorkflowDataUseCase uc;

    this(ManageWorkflowDataUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/workflow/deadlines", &handleList);
        router.get("/api/v1/workflow/deadlines/*", &handleGet);
        router.post("/api/v1/workflow/deadlines", &handleCreate);
        router.put("/api/v1/workflow/deadlines/*", &handleUpdate);
        router.delete_("/api/v1/workflow/deadlines/*", &handleDelete);
        router.get("/api/v1/sap-advanced-workflow/deadline-escalations", &handleList);
        router.get("/api/v1/sap-advanced-workflow/deadline-escalations/*", &handleGet);
        router.post("/api/v1/sap-advanced-workflow/deadline-escalations", &handleCreate);
        router.put("/api/v1/sap-advanced-workflow/deadline-escalations/*", &handleUpdate);
        router.delete_("/api/v1/sap-advanced-workflow/deadline-escalations/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.listDeadlines(), &deadlineEscalationToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.getDeadline(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Deadline escalation not found"); return; }
            res.writeJsonBody(deadlineEscalationToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            DeadlineEscalationDTO dto;
            dto.id = jsonStrAny(j, ["id", "deadlineEscalationId"]);
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.taskId = jsonStrAny(j, ["taskId", "workflowTaskId"]);
            dto.escalationRole = jsonStrAny(j, ["escalationRole", "escalationTargetRole"]);
            dto.escalationAt = jsonStrAny(j, ["escalationAt", "escalatedAt"]);
            dto.reason = jsonStrAny(j, ["reason", "escalationReason"]);
            dto.notified = jsonBoolAny(j, ["notified", "notificationSent"], false);

            auto result = uc.createDeadline(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Deadline escalation created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            DeadlineEscalationDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.escalationRole = jsonStrAny(j, ["escalationRole", "escalationTargetRole"]);
            dto.escalationAt = jsonStrAny(j, ["escalationAt", "escalatedAt"]);
            dto.reason = jsonStrAny(j, ["reason", "escalationReason"]);
            dto.notified = jsonBoolAny(j, ["notified", "notificationSent"], false);

            auto result = uc.updateDeadline(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Deadline escalation updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.removeDeadline(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Deadline escalation deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class WorkflowSubstitutionController : SAPController {
    private ManageWorkflowDataUseCase uc;

    this(ManageWorkflowDataUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/workflow/substitutions", &handleList);
        router.get("/api/v1/workflow/substitutions/*", &handleGet);
        router.post("/api/v1/workflow/substitutions", &handleCreate);
        router.put("/api/v1/workflow/substitutions/*", &handleUpdate);
        router.delete_("/api/v1/workflow/substitutions/*", &handleDelete);
        router.get("/api/v1/sap-advanced-workflow/workflow-substitutions", &handleList);
        router.get("/api/v1/sap-advanced-workflow/workflow-substitutions/*", &handleGet);
        router.post("/api/v1/sap-advanced-workflow/workflow-substitutions", &handleCreate);
        router.put("/api/v1/sap-advanced-workflow/workflow-substitutions/*", &handleUpdate);
        router.delete_("/api/v1/sap-advanced-workflow/workflow-substitutions/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.listSubstitutions(), &workflowSubstitutionToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.getSubstitution(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Substitution not found"); return; }
            res.writeJsonBody(workflowSubstitutionToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowSubstitutionDTO dto;
            dto.id = jsonStrAny(j, ["id", "workflowSubstitutionId"]);
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.principalUser = jsonStrAny(j, ["principalUser", "originalUser"]);
            dto.substituteUser = jsonStrAny(j, ["substituteUser", "delegateUser"]);
            dto.validFrom = jsonStrAny(j, ["validFrom", "substituteFrom"]);
            dto.validTo = jsonStrAny(j, ["validTo", "substituteTo"]);
            dto.active = jsonBoolAny(j, ["active", "isActive"], false);

            auto result = uc.createSubstitution(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Substitution created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowSubstitutionDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.substituteUser = jsonStrAny(j, ["substituteUser", "delegateUser"]);
            dto.validFrom = jsonStrAny(j, ["validFrom", "substituteFrom"]);
            dto.validTo = jsonStrAny(j, ["validTo", "substituteTo"]);
            dto.active = jsonBoolAny(j, ["active", "isActive"], false);

            auto result = uc.updateSubstitution(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Substitution updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.removeSubstitution(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Substitution deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class WorkflowContextController : SAPController {
    private ManageWorkflowDataUseCase uc;

    this(ManageWorkflowDataUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/workflow/contexts", &handleList);
        router.get("/api/v1/workflow/contexts/*", &handleGet);
        router.post("/api/v1/workflow/contexts", &handleCreate);
        router.put("/api/v1/workflow/contexts/*", &handleUpdate);
        router.delete_("/api/v1/workflow/contexts/*", &handleDelete);
        router.get("/api/v1/sap-advanced-workflow/workflow-contexts", &handleList);
        router.get("/api/v1/sap-advanced-workflow/workflow-contexts/*", &handleGet);
        router.post("/api/v1/sap-advanced-workflow/workflow-contexts", &handleCreate);
        router.put("/api/v1/sap-advanced-workflow/workflow-contexts/*", &handleUpdate);
        router.delete_("/api/v1/sap-advanced-workflow/workflow-contexts/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.listContexts(), &workflowContextToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.getContext(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Workflow context not found"); return; }
            res.writeJsonBody(workflowContextToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowContextDTO dto;
            dto.id = jsonStrAny(j, ["id", "workflowContextId"]);
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.instanceId = jsonStrAny(j, ["instanceId", "workflowInstanceId"]);
            dto.key = jsonStrAny(j, ["key", "contextKey"]);
            dto.value = jsonStrAny(j, ["value", "contextValue"]);

            auto result = uc.createContext(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow context created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowContextDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.value = jsonStrAny(j, ["value", "contextValue"]);

            auto result = uc.updateContext(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow context updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.removeContext(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Workflow context deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class WorkflowEventController : SAPController {
    private ManageWorkflowDataUseCase uc;

    this(ManageWorkflowDataUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/workflow/events", &handleList);
        router.get("/api/v1/workflow/events/*", &handleGet);
        router.post("/api/v1/workflow/events", &handleCreate);
        router.put("/api/v1/workflow/events/*", &handleUpdate);
        router.delete_("/api/v1/workflow/events/*", &handleDelete);
        router.get("/api/v1/sap-advanced-workflow/workflow-events", &handleList);
        router.get("/api/v1/sap-advanced-workflow/workflow-events/*", &handleGet);
        router.post("/api/v1/sap-advanced-workflow/workflow-events", &handleCreate);
        router.put("/api/v1/sap-advanced-workflow/workflow-events/*", &handleUpdate);
        router.delete_("/api/v1/sap-advanced-workflow/workflow-events/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.listEvents(), &workflowEventToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.getEvent(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Workflow event not found"); return; }
            res.writeJsonBody(workflowEventToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowEventDTO dto;
            dto.id = jsonStrAny(j, ["id", "workflowEventId"]);
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.instanceId = jsonStrAny(j, ["instanceId", "workflowInstanceId"]);
            dto.kind = jsonStrAny(j, ["kind", "eventType"]);
            dto.actor = jsonStrAny(j, ["actor", "eventActor"]);
            dto.occurredAt = jsonStrAny(j, ["occurredAt", "eventTime"]);
            dto.details = jsonStrAny(j, ["details", "eventDetails"]);

            auto result = uc.createEvent(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow event created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkflowEventDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.kind = jsonStrAny(j, ["kind", "eventType"]);
            dto.actor = jsonStrAny(j, ["actor", "eventActor"]);
            dto.occurredAt = jsonStrAny(j, ["occurredAt", "eventTime"]);
            dto.details = jsonStrAny(j, ["details", "eventDetails"]);

            auto result = uc.updateEvent(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Workflow event updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.removeEvent(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Workflow event deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}
