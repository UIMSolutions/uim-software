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
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.category = jsonStr(j, "category");
            dto.starterRole = jsonStr(j, "starterRole");
            dto.priority = jsonStr(j, "priority");
            dto.status = jsonStr(j, "status");
            dto.createdBy = jsonStr(j, "createdBy");

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
            dto.name = jsonStr(j, "name");
            dto.category = jsonStr(j, "category");
            dto.starterRole = jsonStr(j, "starterRole");
            dto.priority = jsonStr(j, "priority");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

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
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.definitionId = jsonStr(j, "definitionId");
            dto.businessObjectType = jsonStr(j, "businessObjectType");
            dto.businessObjectId = jsonStr(j, "businessObjectId");
            dto.status = jsonStr(j, "status");
            dto.startedBy = jsonStr(j, "startedBy");
            dto.startedAt = jsonStr(j, "startedAt");
            dto.completedAt = jsonStr(j, "completedAt");

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
            dto.status = jsonStr(j, "status");
            dto.completedAt = jsonStr(j, "completedAt");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

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
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.instanceId = jsonStr(j, "instanceId");
            dto.title = jsonStr(j, "title");
            dto.assignee = jsonStr(j, "assignee");
            dto.dueDate = jsonStr(j, "dueDate");
            dto.priority = jsonStr(j, "priority");
            dto.state = jsonStr(j, "state");

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
            dto.assignee = jsonStr(j, "assignee");
            dto.dueDate = jsonStr(j, "dueDate");
            dto.priority = jsonStr(j, "priority");
            dto.state = jsonStr(j, "state");
            dto.completedBy = jsonStr(j, "completedBy");
            dto.completedAt = jsonStr(j, "completedAt");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

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
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.taskId = jsonStr(j, "taskId");
            dto.decision = jsonStr(j, "decision");
            dto.comment = jsonStr(j, "comment");
            dto.decidedBy = jsonStr(j, "decidedBy");
            dto.decidedAt = jsonStr(j, "decidedAt");

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
            dto.decision = jsonStr(j, "decision");
            dto.comment = jsonStr(j, "comment");
            dto.decidedBy = jsonStr(j, "decidedBy");
            dto.decidedAt = jsonStr(j, "decidedAt");

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
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.taskId = jsonStr(j, "taskId");
            dto.escalationRole = jsonStr(j, "escalationRole");
            dto.escalationAt = jsonStr(j, "escalationAt");
            dto.reason = jsonStr(j, "reason");
            dto.notified = jsonBool(j, "notified", false);

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
            dto.escalationRole = jsonStr(j, "escalationRole");
            dto.escalationAt = jsonStr(j, "escalationAt");
            dto.reason = jsonStr(j, "reason");
            dto.notified = jsonBool(j, "notified", false);

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
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.principalUser = jsonStr(j, "principalUser");
            dto.substituteUser = jsonStr(j, "substituteUser");
            dto.validFrom = jsonStr(j, "validFrom");
            dto.validTo = jsonStr(j, "validTo");
            dto.active = jsonBool(j, "active", false);

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
            dto.substituteUser = jsonStr(j, "substituteUser");
            dto.validFrom = jsonStr(j, "validFrom");
            dto.validTo = jsonStr(j, "validTo");
            dto.active = jsonBool(j, "active", false);

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
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.instanceId = jsonStr(j, "instanceId");
            dto.key = jsonStr(j, "key");
            dto.value = jsonStr(j, "value");

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
            dto.value = jsonStr(j, "value");

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
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.instanceId = jsonStr(j, "instanceId");
            dto.kind = jsonStr(j, "kind");
            dto.actor = jsonStr(j, "actor");
            dto.occurredAt = jsonStr(j, "occurredAt");
            dto.details = jsonStr(j, "details");

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
            dto.kind = jsonStr(j, "kind");
            dto.actor = jsonStr(j, "actor");
            dto.occurredAt = jsonStr(j, "occurredAt");
            dto.details = jsonStr(j, "details");

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
