module uim.platform.workflow.domain.repositories.workflow_repositories;

import uim.platform.workflow.domain.entities.workflow_entities;
import uim.platform.workflow.domain.types;

@safe:

interface WorkflowDefinitionRepository {
    WorkflowDefinition[] findAll();
    WorkflowDefinition* findById(WorkflowDefinitionId id);
    void save(WorkflowDefinition value);
    void update(WorkflowDefinition value);
    void remove(WorkflowDefinitionId id);
}

interface WorkflowInstanceRepository {
    WorkflowInstance[] findAll();
    WorkflowInstance* findById(WorkflowInstanceId id);
    void save(WorkflowInstance value);
    void update(WorkflowInstance value);
    void remove(WorkflowInstanceId id);
}

interface WorkflowTaskRepository {
    WorkflowTask[] findAll();
    WorkflowTask* findById(WorkflowTaskId id);
    void save(WorkflowTask value);
    void update(WorkflowTask value);
    void remove(WorkflowTaskId id);
}

interface ApprovalDecisionRepository {
    ApprovalDecision[] findAll();
    ApprovalDecision* findById(ApprovalDecisionId id);
    void save(ApprovalDecision value);
    void update(ApprovalDecision value);
    void remove(ApprovalDecisionId id);
}

interface DeadlineEscalationRepository {
    DeadlineEscalation[] findAll();
    DeadlineEscalation* findById(DeadlineEscalationId id);
    void save(DeadlineEscalation value);
    void update(DeadlineEscalation value);
    void remove(DeadlineEscalationId id);
}

interface WorkflowSubstitutionRepository {
    WorkflowSubstitution[] findAll();
    WorkflowSubstitution* findById(WorkflowSubstitutionId id);
    void save(WorkflowSubstitution value);
    void update(WorkflowSubstitution value);
    void remove(WorkflowSubstitutionId id);
}

interface WorkflowContextRepository {
    WorkflowContext[] findAll();
    WorkflowContext* findById(WorkflowContextId id);
    void save(WorkflowContext value);
    void update(WorkflowContext value);
    void remove(WorkflowContextId id);
}

interface WorkflowEventRepository {
    WorkflowEvent[] findAll();
    WorkflowEvent* findById(WorkflowEventId id);
    void save(WorkflowEvent value);
    void update(WorkflowEvent value);
    void remove(WorkflowEventId id);
}
