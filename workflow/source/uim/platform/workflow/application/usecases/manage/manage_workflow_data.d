module uim.platform.workflow.application.usecases.manage.manage_workflow_data;

import std.string : toLower;

import uim.platform.workflow.application.dto;
import uim.platform.workflow.domain.entities.workflow_entities;
import uim.platform.workflow.domain.repositories.workflow_repositories;
import uim.platform.workflow.domain.services.workflow_validator;
import uim.platform.workflow.domain.types;

@safe:

private WorkflowLifecycle parseWorkflowLifecycle(string value, WorkflowLifecycle fallback = WorkflowLifecycle.draft) {
    switch (value.toLower()) {
        case "draft": return WorkflowLifecycle.draft;
        case "active": return WorkflowLifecycle.active;
        case "suspended": return WorkflowLifecycle.suspended;
        case "completed": return WorkflowLifecycle.completed;
        case "cancelled": return WorkflowLifecycle.cancelled;
        default: return fallback;
    }
}

private TaskState parseTaskState(string value, TaskState fallback = TaskState.ready) {
    switch (value.toLower()) {
        case "ready": return TaskState.ready;
        case "reserved": return TaskState.reserved;
        case "inprogress": return TaskState.inProgress;
        case "completed": return TaskState.completed;
        case "escalated": return TaskState.escalated;
        case "skipped": return TaskState.skipped;
        default: return fallback;
    }
}

private Priority parsePriority(string value, Priority fallback = Priority.normal) {
    switch (value.toLower()) {
        case "low": return Priority.low;
        case "normal": return Priority.normal;
        case "high": return Priority.high;
        case "critical": return Priority.critical;
        default: return fallback;
    }
}

private DecisionType parseDecisionType(string value, DecisionType fallback = DecisionType.approve) {
    switch (value.toLower()) {
        case "approve": return DecisionType.approve;
        case "reject": return DecisionType.reject;
        case "rework": return DecisionType.rework;
        case "information": return DecisionType.information;
        default: return fallback;
    }
}

private EventKind parseEventKind(string value, EventKind fallback = EventKind.start) {
    switch (value.toLower()) {
        case "start": return EventKind.start;
        case "submit": return EventKind.submit;
        case "complete": return EventKind.complete;
        case "escalation": return EventKind.escalation;
        case "cancellation": return EventKind.cancellation;
        default: return fallback;
    }
}

class ManageWorkflowDataUseCase {
    private WorkflowDefinitionRepository definitionRepo;
    private WorkflowInstanceRepository instanceRepo;
    private WorkflowTaskRepository taskRepo;
    private ApprovalDecisionRepository decisionRepo;
    private DeadlineEscalationRepository deadlineRepo;
    private WorkflowSubstitutionRepository substitutionRepo;
    private WorkflowContextRepository contextRepo;
    private WorkflowEventRepository eventRepo;

    this(
        WorkflowDefinitionRepository definitionRepo,
        WorkflowInstanceRepository instanceRepo,
        WorkflowTaskRepository taskRepo,
        ApprovalDecisionRepository decisionRepo,
        DeadlineEscalationRepository deadlineRepo,
        WorkflowSubstitutionRepository substitutionRepo,
        WorkflowContextRepository contextRepo,
        WorkflowEventRepository eventRepo
    ) {
        this.definitionRepo = definitionRepo;
        this.instanceRepo = instanceRepo;
        this.taskRepo = taskRepo;
        this.decisionRepo = decisionRepo;
        this.deadlineRepo = deadlineRepo;
        this.substitutionRepo = substitutionRepo;
        this.contextRepo = contextRepo;
        this.eventRepo = eventRepo;
    }

    WorkflowDefinition[] listDefinitions() { return definitionRepo.findAll(); }
    WorkflowDefinition* getDefinition(WorkflowDefinitionId id) { return definitionRepo.findById(id); }

    CommandResult createDefinition(WorkflowDefinitionDTO dto) {
        WorkflowDefinition value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.name = dto.name;
        value.category = dto.category;
        value.starterRole = dto.starterRole;
        value.priority = parsePriority(dto.priority);
        value.status = parseWorkflowLifecycle(dto.status);
        value.createdBy = dto.createdBy;

        if (!WorkflowValidator.valid(value))
            return CommandResult(false, "", "Invalid workflow definition data");

        definitionRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateDefinition(WorkflowDefinitionDTO dto) {
        auto existing = definitionRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Workflow definition not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.category.length > 0) existing.category = dto.category;
        if (dto.starterRole.length > 0) existing.starterRole = dto.starterRole;
        if (dto.priority.length > 0) existing.priority = parsePriority(dto.priority, existing.priority);
        if (dto.status.length > 0) existing.status = parseWorkflowLifecycle(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        definitionRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeDefinition(WorkflowDefinitionId id) {
        auto existing = definitionRepo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Workflow definition not found");
        definitionRepo.remove(id);
        return CommandResult(true, id, "");
    }

    WorkflowInstance[] listInstances() { return instanceRepo.findAll(); }
    WorkflowInstance* getInstance(WorkflowInstanceId id) { return instanceRepo.findById(id); }

    CommandResult createInstance(WorkflowInstanceDTO dto) {
        WorkflowInstance value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.definitionId = dto.definitionId;
        value.businessObjectType = dto.businessObjectType;
        value.businessObjectId = dto.businessObjectId;
        value.status = parseWorkflowLifecycle(dto.status, WorkflowLifecycle.active);
        value.startedBy = dto.startedBy;
        value.startedAt = dto.startedAt;
        value.completedAt = dto.completedAt;

        if (!WorkflowValidator.valid(value))
            return CommandResult(false, "", "Invalid workflow instance data");

        instanceRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateInstance(WorkflowInstanceDTO dto) {
        auto existing = instanceRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Workflow instance not found");

        if (dto.status.length > 0) existing.status = parseWorkflowLifecycle(dto.status, existing.status);
        if (dto.completedAt.length > 0) existing.completedAt = dto.completedAt;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        instanceRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeInstance(WorkflowInstanceId id) {
        auto existing = instanceRepo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Workflow instance not found");
        instanceRepo.remove(id);
        return CommandResult(true, id, "");
    }

    WorkflowTask[] listTasks() { return taskRepo.findAll(); }
    WorkflowTask* getTask(WorkflowTaskId id) { return taskRepo.findById(id); }

    CommandResult createTask(WorkflowTaskDTO dto) {
        WorkflowTask value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.instanceId = dto.instanceId;
        value.title = dto.title;
        value.assignee = dto.assignee;
        value.dueDate = dto.dueDate;
        value.priority = parsePriority(dto.priority);
        value.state = parseTaskState(dto.state);

        if (!WorkflowValidator.valid(value))
            return CommandResult(false, "", "Invalid workflow task data");

        taskRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateTask(WorkflowTaskDTO dto) {
        auto existing = taskRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Workflow task not found");

        if (dto.assignee.length > 0) existing.assignee = dto.assignee;
        if (dto.dueDate.length > 0) existing.dueDate = dto.dueDate;
        if (dto.priority.length > 0) existing.priority = parsePriority(dto.priority, existing.priority);
        if (dto.state.length > 0) existing.state = parseTaskState(dto.state, existing.state);
        if (dto.completedBy.length > 0) existing.completedBy = dto.completedBy;
        if (dto.completedAt.length > 0) existing.completedAt = dto.completedAt;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        taskRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeTask(WorkflowTaskId id) {
        auto existing = taskRepo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Workflow task not found");
        taskRepo.remove(id);
        return CommandResult(true, id, "");
    }

    ApprovalDecision[] listDecisions() { return decisionRepo.findAll(); }
    ApprovalDecision* getDecision(ApprovalDecisionId id) { return decisionRepo.findById(id); }

    CommandResult createDecision(ApprovalDecisionDTO dto) {
        ApprovalDecision value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.taskId = dto.taskId;
        value.decision = parseDecisionType(dto.decision);
        value.comment = dto.comment;
        value.decidedBy = dto.decidedBy;
        value.decidedAt = dto.decidedAt;

        if (!WorkflowValidator.valid(value))
            return CommandResult(false, "", "Invalid approval decision data");

        decisionRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateDecision(ApprovalDecisionDTO dto) {
        auto existing = decisionRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Approval decision not found");

        if (dto.decision.length > 0) existing.decision = parseDecisionType(dto.decision, existing.decision);
        if (dto.comment.length > 0) existing.comment = dto.comment;
        if (dto.decidedBy.length > 0) existing.decidedBy = dto.decidedBy;
        if (dto.decidedAt.length > 0) existing.decidedAt = dto.decidedAt;

        decisionRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeDecision(ApprovalDecisionId id) {
        auto existing = decisionRepo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Approval decision not found");
        decisionRepo.remove(id);
        return CommandResult(true, id, "");
    }

    DeadlineEscalation[] listDeadlines() { return deadlineRepo.findAll(); }
    DeadlineEscalation* getDeadline(DeadlineEscalationId id) { return deadlineRepo.findById(id); }

    CommandResult createDeadline(DeadlineEscalationDTO dto) {
        DeadlineEscalation value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.taskId = dto.taskId;
        value.escalationRole = dto.escalationRole;
        value.escalationAt = dto.escalationAt;
        value.reason = dto.reason;
        value.notified = dto.notified;

        if (!WorkflowValidator.valid(value))
            return CommandResult(false, "", "Invalid deadline escalation data");

        deadlineRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateDeadline(DeadlineEscalationDTO dto) {
        auto existing = deadlineRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Deadline escalation not found");

        if (dto.escalationRole.length > 0) existing.escalationRole = dto.escalationRole;
        if (dto.escalationAt.length > 0) existing.escalationAt = dto.escalationAt;
        if (dto.reason.length > 0) existing.reason = dto.reason;
        existing.notified = dto.notified;

        deadlineRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeDeadline(DeadlineEscalationId id) {
        auto existing = deadlineRepo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Deadline escalation not found");
        deadlineRepo.remove(id);
        return CommandResult(true, id, "");
    }

    WorkflowSubstitution[] listSubstitutions() { return substitutionRepo.findAll(); }
    WorkflowSubstitution* getSubstitution(WorkflowSubstitutionId id) { return substitutionRepo.findById(id); }

    CommandResult createSubstitution(WorkflowSubstitutionDTO dto) {
        WorkflowSubstitution value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.principalUser = dto.principalUser;
        value.substituteUser = dto.substituteUser;
        value.validFrom = dto.validFrom;
        value.validTo = dto.validTo;
        value.active = dto.active;

        if (!WorkflowValidator.valid(value))
            return CommandResult(false, "", "Invalid substitution data");

        substitutionRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateSubstitution(WorkflowSubstitutionDTO dto) {
        auto existing = substitutionRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Substitution not found");

        if (dto.substituteUser.length > 0) existing.substituteUser = dto.substituteUser;
        if (dto.validFrom.length > 0) existing.validFrom = dto.validFrom;
        if (dto.validTo.length > 0) existing.validTo = dto.validTo;
        existing.active = dto.active;

        substitutionRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeSubstitution(WorkflowSubstitutionId id) {
        auto existing = substitutionRepo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Substitution not found");
        substitutionRepo.remove(id);
        return CommandResult(true, id, "");
    }

    WorkflowContext[] listContexts() { return contextRepo.findAll(); }
    WorkflowContext* getContext(WorkflowContextId id) { return contextRepo.findById(id); }

    CommandResult createContext(WorkflowContextDTO dto) {
        WorkflowContext value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.instanceId = dto.instanceId;
        value.key = dto.key;
        value.value = dto.value;

        if (!WorkflowValidator.valid(value))
            return CommandResult(false, "", "Invalid workflow context data");

        contextRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateContext(WorkflowContextDTO dto) {
        auto existing = contextRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Workflow context not found");

        if (dto.value.length > 0) existing.value = dto.value;

        contextRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeContext(WorkflowContextId id) {
        auto existing = contextRepo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Workflow context not found");
        contextRepo.remove(id);
        return CommandResult(true, id, "");
    }

    WorkflowEvent[] listEvents() { return eventRepo.findAll(); }
    WorkflowEvent* getEvent(WorkflowEventId id) { return eventRepo.findById(id); }

    CommandResult createEvent(WorkflowEventDTO dto) {
        WorkflowEvent value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.instanceId = dto.instanceId;
        value.kind = parseEventKind(dto.kind);
        value.actor = dto.actor;
        value.occurredAt = dto.occurredAt;
        value.details = dto.details;

        if (!WorkflowValidator.valid(value))
            return CommandResult(false, "", "Invalid workflow event data");

        eventRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateEvent(WorkflowEventDTO dto) {
        auto existing = eventRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Workflow event not found");

        if (dto.kind.length > 0) existing.kind = parseEventKind(dto.kind, existing.kind);
        if (dto.actor.length > 0) existing.actor = dto.actor;
        if (dto.occurredAt.length > 0) existing.occurredAt = dto.occurredAt;
        if (dto.details.length > 0) existing.details = dto.details;

        eventRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeEvent(WorkflowEventId id) {
        auto existing = eventRepo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Workflow event not found");
        eventRepo.remove(id);
        return CommandResult(true, id, "");
    }
}
