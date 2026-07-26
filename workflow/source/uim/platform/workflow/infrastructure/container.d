module uim.platform.workflow.infrastructure.container;

import uim.platform.workflow;

@safe:

struct Container {
    AppConfig config;

    ManageWorkflowDataUseCase manageWorkflowDataUseCase;

    WorkflowHealthController healthController;
    WorkflowOpenApiController openApiController;
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

    WorkflowDefinitionRepository definitionRepo;
    WorkflowInstanceRepository instanceRepo;
    WorkflowTaskRepository taskRepo;
    ApprovalDecisionRepository decisionRepo;
    DeadlineEscalationRepository deadlineRepo;
    WorkflowSubstitutionRepository substitutionRepo;
    WorkflowContextRepository contextRepo;
    WorkflowEventRepository eventRepo;

    if (config.storage == "file") {
        definitionRepo = new FileWorkflowDefinitionRepository(config.storagePath);
        instanceRepo = new FileWorkflowInstanceRepository(config.storagePath);
        taskRepo = new FileWorkflowTaskRepository(config.storagePath);
        decisionRepo = new FileApprovalDecisionRepository(config.storagePath);
        deadlineRepo = new FileDeadlineEscalationRepository(config.storagePath);
        substitutionRepo = new FileWorkflowSubstitutionRepository(config.storagePath);
        contextRepo = new FileWorkflowContextRepository(config.storagePath);
        eventRepo = new FileWorkflowEventRepository(config.storagePath);
    } else {
        definitionRepo = new MemoryWorkflowDefinitionRepository();
        instanceRepo = new MemoryWorkflowInstanceRepository();
        taskRepo = new MemoryWorkflowTaskRepository();
        decisionRepo = new MemoryApprovalDecisionRepository();
        deadlineRepo = new MemoryDeadlineEscalationRepository();
        substitutionRepo = new MemoryWorkflowSubstitutionRepository();
        contextRepo = new MemoryWorkflowContextRepository();
        eventRepo = new MemoryWorkflowEventRepository();
    }

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
    container.openApiController = new WorkflowOpenApiController();
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
