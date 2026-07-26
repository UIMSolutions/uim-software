module uim.platform.alm.infrastructure.persistence.memory;

import uim.platform.alm.domain;

@safe:

private SolutionId solutionId(ref const Solution value) { return value.id; }
private void setSolutionId(ref Solution value, SolutionId id) { value.id = id; }

private ProjectId projectId(ref const Project value) { return value.id; }
private void setProjectId(ref Project value, ProjectId id) { value.id = id; }

private TaskId taskId(ref const Task value) { return value.id; }
private void setTaskId(ref Task value, TaskId id) { value.id = id; }

private TestPlanId testPlanId(ref const TestPlan value) { return value.id; }
private void setTestPlanId(ref TestPlan value, TestPlanId id) { value.id = id; }

private TestCaseId testCaseId(ref const TestCase value) { return value.id; }
private void setTestCaseId(ref TestCase value, TestCaseId id) { value.id = id; }

private DefectId defectId(ref const Defect value) { return value.id; }
private void setDefectId(ref Defect value, DefectId id) { value.id = id; }

private ReleaseId releaseId(ref const Release value) { return value.id; }
private void setReleaseId(ref Release value, ReleaseId id) { value.id = id; }

private DeploymentId deploymentId(ref const Deployment value) { return value.id; }
private void setDeploymentId(ref Deployment value, DeploymentId id) { value.id = id; }

private EnvironmentId environmentId(ref const Environment value) { return value.id; }
private void setEnvironmentId(ref Environment value, EnvironmentId id) { value.id = id; }

private AlertId alertId(ref const Alert value) { return value.id; }
private void setAlertId(ref Alert value, AlertId id) { value.id = id; }

class MemoryCrudRepository(T, IdType, alias getId, alias setId) : CrudRepository!(T, IdType) {
    private T[] store;

    T[] findAll() {
        return store.dup;
    }

    T[] findByTenant(TenantId tenantId) {
        if (tenantId.length == 0)
            return findAll();

        T[] result;
        foreach (ref item; store) {
            if (item.tenantId == tenantId)
                result ~= item;
        }
        return result;
    }

    T* findById(IdType id) @trusted {
        for (size_t index = 0; index < store.length; ++index) {
            if (getId(store[index]) == id)
                return &store[index];
        }
        return null;
    }

    void save(T value) {
        auto existing = findById(getId(value));
        if (existing is null) {
            store ~= value;
            return;
        }

        *existing = value;
    }

    void update(T value) {
        save(value);
    }

    bool remove(IdType id) {
        for (size_t index = 0; index < store.length; ++index) {
            if (getId(store[index]) == id) {
                if (index + 1 < store.length)
                    store = store[0 .. index] ~ store[index + 1 .. $];
                else
                    store = store[0 .. index];
                return true;
            }
        }
        return false;
    }
}

version(unittest) {
    unittest {
        auto repo = new MemoryCrudRepository!(Solution, SolutionId, solutionId, setSolutionId)();
        Solution item;
        item.id = "solution-1";
        item.tenantId = "tenant-1";
        item.name = "Solution";
        repo.save(item);
        assert(repo.findAll().length == 1);
        assert(repo.findById("solution-1") !is null);
        assert(repo.findByTenant("tenant-1").length == 1);
        assert(repo.remove("solution-1"));
    }
}
