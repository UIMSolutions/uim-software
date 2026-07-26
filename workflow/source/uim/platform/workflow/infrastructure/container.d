module uim.platform.workflow.infrastructure.container;

import uim.platform.workflow;

@safe:

struct Container {
    AppConfig config;

    ManageWorkflowDataUseCase manageWorkflowDataUseCase;

    WorkflowHealthController healthController;
    WorkflowWebClientController webClientController;
    WorkflowDefinitionController workflowDefinitionController;
    WorkflowInstanceController workflowInstanceController;
    WorkflowTaskController workflowTaskController;
    ApprovalDecisionController approvalDecisionController;
    DeadlineEscalationController deadlineEscalationController;
    WorkflowSubstitutionController workflowSubstitutionController;
    WorkflowContextController workflowContextController;
    WorkflowEventController workflowEventController;
}

Container buildContainer(AppConfig config) {
    Container container;
    container.config = config;

    auto definitionRepo = new MemoryWorkflowDefinitionRepository();
    auto instanceRepo = new MemoryWorkflowInstanceRepository();
    auto taskRepo = new MemoryWorkflowTaskRepository();
    auto decisionRepo = new MemoryApprovalDecisionRepository();
    auto deadlineRepo = new MemoryDeadlineEscalationRepository();
    auto substitutionRepo = new MemoryWorkflowSubstitutionRepository();
    auto contextRepo = new MemoryWorkflowContextRepository();
    auto eventRepo = new MemoryWorkflowEventRepository();

    container.manageWorkflowDataUseCase = new ManageWorkflowDataUseCase(
        definitionRepo,
        instanceRepo,
        taskRepo,
        decisionRepo,
        deadlineRepo,
        substitutionRepo,
        contextRepo,
        eventRepo
    );

    container.healthController = new WorkflowHealthController();
    container.webClientController = new WorkflowWebClientController();
    container.workflowDefinitionController = new WorkflowDefinitionController(container.manageWorkflowDataUseCase);
    container.workflowInstanceController = new WorkflowInstanceController(container.manageWorkflowDataUseCase);
    container.workflowTaskController = new WorkflowTaskController(container.manageWorkflowDataUseCase);
    container.approvalDecisionController = new ApprovalDecisionController(container.manageWorkflowDataUseCase);
    container.deadlineEscalationController = new DeadlineEscalationController(container.manageWorkflowDataUseCase);
    container.workflowSubstitutionController = new WorkflowSubstitutionController(container.manageWorkflowDataUseCase);
    container.workflowContextController = new WorkflowContextController(container.manageWorkflowDataUseCase);
    container.workflowEventController = new WorkflowEventController(container.manageWorkflowDataUseCase);

    return container;
}
