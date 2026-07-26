module uim.platform.workflow.application.usecases.manage.workflow_feature_tests;

import uim.platform.workflow;

@safe unittest {
    auto definitionRepo = new MemoryWorkflowDefinitionRepository();
    auto instanceRepo = new MemoryWorkflowInstanceRepository();
    auto taskRepo = new MemoryWorkflowTaskRepository();
    auto decisionRepo = new MemoryApprovalDecisionRepository();
    auto deadlineRepo = new MemoryDeadlineEscalationRepository();
    auto substitutionRepo = new MemoryWorkflowSubstitutionRepository();
    auto contextRepo = new MemoryWorkflowContextRepository();
    auto eventRepo = new MemoryWorkflowEventRepository();

    auto uc = new ManageWorkflowDataUseCase(
        definitionRepo,
        instanceRepo,
        taskRepo,
        decisionRepo,
        deadlineRepo,
        substitutionRepo,
        contextRepo,
        eventRepo
    );

    WorkflowDefinitionDTO dto;
    dto.id = "WF-DEF-001";
    dto.tenantId = "TEN-1";
    dto.name = "Purchase Requisition Approval";
    dto.category = "Procurement";
    dto.starterRole = "Requester";
    dto.priority = "high";
    dto.status = "active";
    dto.createdBy = "admin";

    auto result = uc.createDefinition(dto);
    assert(result.success);
    assert(definitionRepo.findAll().length == 1);
    assert(definitionRepo.findAll()[0].priority == Priority.high);
}

@safe unittest {
    auto definitionRepo = new MemoryWorkflowDefinitionRepository();
    auto instanceRepo = new MemoryWorkflowInstanceRepository();
    auto taskRepo = new MemoryWorkflowTaskRepository();
    auto decisionRepo = new MemoryApprovalDecisionRepository();
    auto deadlineRepo = new MemoryDeadlineEscalationRepository();
    auto substitutionRepo = new MemoryWorkflowSubstitutionRepository();
    auto contextRepo = new MemoryWorkflowContextRepository();
    auto eventRepo = new MemoryWorkflowEventRepository();

    auto uc = new ManageWorkflowDataUseCase(
        definitionRepo,
        instanceRepo,
        taskRepo,
        decisionRepo,
        deadlineRepo,
        substitutionRepo,
        contextRepo,
        eventRepo
    );

    WorkflowTaskDTO createTask;
    createTask.id = "WF-TASK-7";
    createTask.tenantId = "TEN-1";
    createTask.instanceId = "WF-INS-2";
    createTask.title = "Approve Budget";
    createTask.assignee = "manager";
    createTask.priority = "normal";
    createTask.state = "ready";

    auto createResult = uc.createTask(createTask);
    assert(createResult.success);

    WorkflowTaskDTO updateTask;
    updateTask.id = "WF-TASK-7";
    updateTask.state = "completed";
    updateTask.completedBy = "manager";
    updateTask.completedAt = "2026-07-26T12:00:00Z";

    auto updateResult = uc.updateTask(updateTask);
    assert(updateResult.success);
    assert(taskRepo.findAll()[0].state == TaskState.completed);
}

@safe unittest {
    auto definitionRepo = new MemoryWorkflowDefinitionRepository();
    auto instanceRepo = new MemoryWorkflowInstanceRepository();
    auto taskRepo = new MemoryWorkflowTaskRepository();
    auto decisionRepo = new MemoryApprovalDecisionRepository();
    auto deadlineRepo = new MemoryDeadlineEscalationRepository();
    auto substitutionRepo = new MemoryWorkflowSubstitutionRepository();
    auto contextRepo = new MemoryWorkflowContextRepository();
    auto eventRepo = new MemoryWorkflowEventRepository();

    auto uc = new ManageWorkflowDataUseCase(
        definitionRepo,
        instanceRepo,
        taskRepo,
        decisionRepo,
        deadlineRepo,
        substitutionRepo,
        contextRepo,
        eventRepo
    );

    ApprovalDecisionDTO decision;
    decision.id = "WF-DEC-11";
    decision.tenantId = "TEN-1";
    decision.taskId = "WF-TASK-7";
    decision.decision = "reject";
    decision.comment = "Missing cost center";
    decision.decidedBy = "controller";
    decision.decidedAt = "2026-07-26T12:03:00Z";

    auto result = uc.createDecision(decision);
    assert(result.success);

    auto removeResult = uc.removeDecision("WF-DEC-11");
    assert(removeResult.success);
    assert(decisionRepo.findAll().length == 0);
}
