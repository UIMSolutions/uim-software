module uim.platform.alm.domain.entities;

import uim.platform.alm.domain.types;

@safe:

struct Solution {
    SolutionId id;
    TenantId tenantId;
    string name;
    string description;
    string owner;
    string businessCapability;
    SolutionLifecycleStage stage = SolutionLifecycleStage.explore;
    RiskLevel riskLevel = RiskLevel.moderate;
    string portfolioTag;
    string createdAt;
    string modifiedAt;
}

struct Project {
    ProjectId id;
    TenantId tenantId;
    SolutionId solutionId;
    string name;
    string description;
    ProjectStatus status = ProjectStatus.planned;
    string deliveryLead;
    string targetGoLiveDate;
    string budgetHint;
    string createdAt;
    string modifiedAt;
}

struct Task {
    TaskId id;
    TenantId tenantId;
    SolutionId solutionId;
    ProjectId projectId;
    string title;
    string description;
    TaskStatus status = TaskStatus.backlog;
    string assignee;
    string dueDate;
    TaskId dependencyTaskId;
    string createdAt;
    string modifiedAt;
}

struct TestPlan {
    TestPlanId id;
    TenantId tenantId;
    SolutionId solutionId;
    string name;
    TestPlanStatus status = TestPlanStatus.draft;
    string owner;
    string objective;
    string createdAt;
    string modifiedAt;
}

struct TestCase {
    TestCaseId id;
    TenantId tenantId;
    TestPlanId planId;
    string name;
    TestCaseStatus status = TestCaseStatus.draft;
    bool automated;
    string priority;
    string requirementRef;
    string createdAt;
    string modifiedAt;
}

struct Defect {
    DefectId id;
    TenantId tenantId;
    SolutionId solutionId;
    TestCaseId testCaseId;
    string title;
    DefectSeverity severity = DefectSeverity.medium;
    DefectStatus status = DefectStatus.new_;
    string rootCause;
    string assignedTo;
    string foundInEnvironment;
    string createdAt;
    string modifiedAt;
}

struct Release {
    ReleaseId id;
    TenantId tenantId;
    SolutionId solutionId;
    string releaseVersion;
    ReleaseStatus status = ReleaseStatus.draft;
    string releaseScope;
    string plannedGoLiveDate;
    string actualGoLiveDate;
    string createdAt;
    string modifiedAt;
}

struct Deployment {
    DeploymentId id;
    TenantId tenantId;
    ReleaseId releaseId;
    EnvironmentId environmentId;
    DeploymentStatus status = DeploymentStatus.scheduled;
    string startedAt;
    string finishedAt;
    string executedBy;
    string logUrl;
    string createdAt;
    string modifiedAt;
}

struct Environment {
    EnvironmentId id;
    TenantId tenantId;
    SolutionId solutionId;
    string name;
    EnvironmentType environmentType = EnvironmentType.dev;
    string region;
    string purpose;
    bool active = true;
    string createdAt;
    string modifiedAt;
}

struct Alert {
    AlertId id;
    TenantId tenantId;
    SolutionId solutionId;
    string source;
    AlertSeverity severity = AlertSeverity.warning;
    AlertStatus status = AlertStatus.open;
    string summary;
    string raisedAt;
    string acknowledgedBy;
    string resolvedAt;
    string createdAt;
    string modifiedAt;
}
