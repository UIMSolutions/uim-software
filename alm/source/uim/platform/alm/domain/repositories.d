module uim.platform.alm.domain.repositories;

import uim.platform.alm.domain.entities;
import uim.platform.alm.domain.types;

@safe:

interface CrudRepository(T, IdType) {
    T[] findAll();
    T[] findByTenant(TenantId tenantId);
    T* findById(IdType id);
    void save(T value);
    void update(T value);
    bool remove(IdType id);
}

alias SolutionRepository = CrudRepository!(Solution, SolutionId);
alias ProjectRepository = CrudRepository!(Project, ProjectId);
alias TaskRepository = CrudRepository!(Task, TaskId);
alias TestPlanRepository = CrudRepository!(TestPlan, TestPlanId);
alias TestCaseRepository = CrudRepository!(TestCase, TestCaseId);
alias DefectRepository = CrudRepository!(Defect, DefectId);
alias ReleaseRepository = CrudRepository!(Release, ReleaseId);
alias DeploymentRepository = CrudRepository!(Deployment, DeploymentId);
alias EnvironmentRepository = CrudRepository!(Environment, EnvironmentId);
alias AlertRepository = CrudRepository!(Alert, AlertId);
