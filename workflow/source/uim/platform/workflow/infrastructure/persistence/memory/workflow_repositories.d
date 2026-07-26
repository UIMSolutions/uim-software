module uim.platform.workflow.infrastructure.persistence.repositories.workflow_repositories;

import std.algorithm : remove;

import uim.platform.workflow.domain.entities.workflow_entities;
import uim.platform.workflow.domain.repositories.workflow_repositories;
import uim.platform.workflow.domain.types;

@safe:

class MemoryWorkflowDefinitionRepository : WorkflowDefinitionRepository {
    private WorkflowDefinition[] store;

    WorkflowDefinition[] findAll() { return store; }

    private @trusted WorkflowDefinition* ptr(WorkflowDefinitionId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowDefinition* findById(WorkflowDefinitionId id) { return ptr(id); }
    void save(WorkflowDefinition value) { store ~= value; }

    void update(WorkflowDefinition value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(WorkflowDefinitionId id) { store = store.remove!(x => x.id == id); }
}

class MemoryWorkflowInstanceRepository : WorkflowInstanceRepository {
    private WorkflowInstance[] store;

    WorkflowInstance[] findAll() { return store; }

    private @trusted WorkflowInstance* ptr(WorkflowInstanceId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowInstance* findById(WorkflowInstanceId id) { return ptr(id); }
    void save(WorkflowInstance value) { store ~= value; }

    void update(WorkflowInstance value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(WorkflowInstanceId id) { store = store.remove!(x => x.id == id); }
}

class MemoryWorkflowTaskRepository : WorkflowTaskRepository {
    private WorkflowTask[] store;

    WorkflowTask[] findAll() { return store; }

    private @trusted WorkflowTask* ptr(WorkflowTaskId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowTask* findById(WorkflowTaskId id) { return ptr(id); }
    void save(WorkflowTask value) { store ~= value; }

    void update(WorkflowTask value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(WorkflowTaskId id) { store = store.remove!(x => x.id == id); }
}

class MemoryApprovalDecisionRepository : ApprovalDecisionRepository {
    private ApprovalDecision[] store;

    ApprovalDecision[] findAll() { return store; }

    private @trusted ApprovalDecision* ptr(ApprovalDecisionId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    ApprovalDecision* findById(ApprovalDecisionId id) { return ptr(id); }
    void save(ApprovalDecision value) { store ~= value; }

    void update(ApprovalDecision value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(ApprovalDecisionId id) { store = store.remove!(x => x.id == id); }
}

class MemoryDeadlineEscalationRepository : DeadlineEscalationRepository {
    private DeadlineEscalation[] store;

    DeadlineEscalation[] findAll() { return store; }

    private @trusted DeadlineEscalation* ptr(DeadlineEscalationId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    DeadlineEscalation* findById(DeadlineEscalationId id) { return ptr(id); }
    void save(DeadlineEscalation value) { store ~= value; }

    void update(DeadlineEscalation value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(DeadlineEscalationId id) { store = store.remove!(x => x.id == id); }
}

class MemoryWorkflowSubstitutionRepository : WorkflowSubstitutionRepository {
    private WorkflowSubstitution[] store;

    WorkflowSubstitution[] findAll() { return store; }

    private @trusted WorkflowSubstitution* ptr(WorkflowSubstitutionId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowSubstitution* findById(WorkflowSubstitutionId id) { return ptr(id); }
    void save(WorkflowSubstitution value) { store ~= value; }

    void update(WorkflowSubstitution value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(WorkflowSubstitutionId id) { store = store.remove!(x => x.id == id); }
}

class MemoryWorkflowContextRepository : WorkflowContextRepository {
    private WorkflowContext[] store;

    WorkflowContext[] findAll() { return store; }

    private @trusted WorkflowContext* ptr(WorkflowContextId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowContext* findById(WorkflowContextId id) { return ptr(id); }
    void save(WorkflowContext value) { store ~= value; }

    void update(WorkflowContext value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(WorkflowContextId id) { store = store.remove!(x => x.id == id); }
}

class MemoryWorkflowEventRepository : WorkflowEventRepository {
    private WorkflowEvent[] store;

    WorkflowEvent[] findAll() { return store; }

    private @trusted WorkflowEvent* ptr(WorkflowEventId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowEvent* findById(WorkflowEventId id) { return ptr(id); }
    void save(WorkflowEvent value) { store ~= value; }

    void update(WorkflowEvent value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(WorkflowEventId id) { store = store.remove!(x => x.id == id); }
}
