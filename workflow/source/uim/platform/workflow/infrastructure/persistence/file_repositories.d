module uim.platform.workflow.infrastructure.persistence.file_repositories;

import std.file : exists, mkdirRecurse, readText, write;
import std.path : buildPath, dirName;

import vibe.data.json : Json, deserializeJson, parseJsonString, serializeToJsonString;

import uim.platform.workflow.domain.entities.workflow_entities;
import uim.platform.workflow.domain.repositories.workflow_repositories;
import uim.platform.workflow.domain.types;

@safe:

private T[] loadStore(T)(string path) {
    if (!exists(path))
        return [];

    try {
        auto raw = readText(path);
        if (raw.length == 0)
            return [];

        auto parsed = parseJsonString(raw);
        return deserializeJson!(T[])(parsed);
    } catch (Exception ex) {
        return [];
    }
}

private void saveStore(T)(string path, T[] data) {
    auto parent = dirName(path);
    if (parent.length > 0 && !exists(parent))
        mkdirRecurse(parent);

    write(path, serializeToJsonString(data));
}

class FileWorkflowDefinitionRepository : WorkflowDefinitionRepository {
    private WorkflowDefinition[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "workflow_definitions.json");
        store = loadStore!WorkflowDefinition(dbPath);
    }

    WorkflowDefinition[] findAll() { return store; }

    private @trusted WorkflowDefinition* ptr(WorkflowDefinitionId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowDefinition* findById(WorkflowDefinitionId id) { return ptr(id); }

    void save(WorkflowDefinition value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(WorkflowDefinition value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(WorkflowDefinitionId id) {
        foreach (i, ref value; store)
            if (value.id == id) {
                store = store[0 .. i] ~ store[i + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
    }
}

class FileWorkflowInstanceRepository : WorkflowInstanceRepository {
    private WorkflowInstance[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "workflow_instances.json");
        store = loadStore!WorkflowInstance(dbPath);
    }

    WorkflowInstance[] findAll() { return store; }

    private @trusted WorkflowInstance* ptr(WorkflowInstanceId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowInstance* findById(WorkflowInstanceId id) { return ptr(id); }

    void save(WorkflowInstance value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(WorkflowInstance value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(WorkflowInstanceId id) {
        foreach (i, ref value; store)
            if (value.id == id) {
                store = store[0 .. i] ~ store[i + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
    }
}

class FileWorkflowTaskRepository : WorkflowTaskRepository {
    private WorkflowTask[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "workflow_tasks.json");
        store = loadStore!WorkflowTask(dbPath);
    }

    WorkflowTask[] findAll() { return store; }

    private @trusted WorkflowTask* ptr(WorkflowTaskId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowTask* findById(WorkflowTaskId id) { return ptr(id); }

    void save(WorkflowTask value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(WorkflowTask value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(WorkflowTaskId id) {
        foreach (i, ref value; store)
            if (value.id == id) {
                store = store[0 .. i] ~ store[i + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
    }
}

class FileApprovalDecisionRepository : ApprovalDecisionRepository {
    private ApprovalDecision[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "approval_decisions.json");
        store = loadStore!ApprovalDecision(dbPath);
    }

    ApprovalDecision[] findAll() { return store; }

    private @trusted ApprovalDecision* ptr(ApprovalDecisionId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    ApprovalDecision* findById(ApprovalDecisionId id) { return ptr(id); }

    void save(ApprovalDecision value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(ApprovalDecision value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(ApprovalDecisionId id) {
        foreach (i, ref value; store)
            if (value.id == id) {
                store = store[0 .. i] ~ store[i + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
    }
}

class FileDeadlineEscalationRepository : DeadlineEscalationRepository {
    private DeadlineEscalation[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "deadline_escalations.json");
        store = loadStore!DeadlineEscalation(dbPath);
    }

    DeadlineEscalation[] findAll() { return store; }

    private @trusted DeadlineEscalation* ptr(DeadlineEscalationId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    DeadlineEscalation* findById(DeadlineEscalationId id) { return ptr(id); }

    void save(DeadlineEscalation value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(DeadlineEscalation value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(DeadlineEscalationId id) {
        foreach (i, ref value; store)
            if (value.id == id) {
                store = store[0 .. i] ~ store[i + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
    }
}

class FileWorkflowSubstitutionRepository : WorkflowSubstitutionRepository {
    private WorkflowSubstitution[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "workflow_substitutions.json");
        store = loadStore!WorkflowSubstitution(dbPath);
    }

    WorkflowSubstitution[] findAll() { return store; }

    private @trusted WorkflowSubstitution* ptr(WorkflowSubstitutionId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowSubstitution* findById(WorkflowSubstitutionId id) { return ptr(id); }

    void save(WorkflowSubstitution value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(WorkflowSubstitution value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(WorkflowSubstitutionId id) {
        foreach (i, ref value; store)
            if (value.id == id) {
                store = store[0 .. i] ~ store[i + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
    }
}

class FileWorkflowContextRepository : WorkflowContextRepository {
    private WorkflowContext[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "workflow_contexts.json");
        store = loadStore!WorkflowContext(dbPath);
    }

    WorkflowContext[] findAll() { return store; }

    private @trusted WorkflowContext* ptr(WorkflowContextId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowContext* findById(WorkflowContextId id) { return ptr(id); }

    void save(WorkflowContext value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(WorkflowContext value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(WorkflowContextId id) {
        foreach (i, ref value; store)
            if (value.id == id) {
                store = store[0 .. i] ~ store[i + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
    }
}

class FileWorkflowEventRepository : WorkflowEventRepository {
    private WorkflowEvent[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "workflow_events.json");
        store = loadStore!WorkflowEvent(dbPath);
    }

    WorkflowEvent[] findAll() { return store; }

    private @trusted WorkflowEvent* ptr(WorkflowEventId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkflowEvent* findById(WorkflowEventId id) { return ptr(id); }

    void save(WorkflowEvent value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(WorkflowEvent value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(WorkflowEventId id) {
        foreach (i, ref value; store)
            if (value.id == id) {
                store = store[0 .. i] ~ store[i + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
    }
}
