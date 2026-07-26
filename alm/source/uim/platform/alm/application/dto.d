module uim.platform.alm.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct SolutionDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string owner;
    string businessCapability;
    string stage;
    string riskLevel;
    string portfolioTag;
    string createdAt;
    string modifiedAt;
}

struct ProjectDTO {
    string id;
    string tenantId;
    string solutionId;
    string name;
    string description;
    string status;
    string deliveryLead;
    string targetGoLiveDate;
    string budgetHint;
    string createdAt;
    string modifiedAt;
}

struct TaskDTO {
    string id;
    string tenantId;
    string solutionId;
    string projectId;
    string title;
    string description;
    string status;
    string assignee;
    string dueDate;
    string dependencyTaskId;
    string createdAt;
    string modifiedAt;
}

struct TestPlanDTO {
    string id;
    string tenantId;
    string solutionId;
    string name;
    string status;
    string owner;
    string objective;
    string createdAt;
    string modifiedAt;
}

struct TestCaseDTO {
    string id;
    string tenantId;
    string planId;
    string name;
    string status;
    bool automated;
    string priority;
    string requirementRef;
    string createdAt;
    string modifiedAt;
}

struct DefectDTO {
    string id;
    string tenantId;
    string solutionId;
    string testCaseId;
    string title;
    string severity;
    string status;
    string rootCause;
    string assignedTo;
    string foundInEnvironment;
    string createdAt;
    string modifiedAt;
}

struct ReleaseDTO {
    string id;
    string tenantId;
    string solutionId;
    string releaseVersion;
    string status;
    string releaseScope;
    string plannedGoLiveDate;
    string actualGoLiveDate;
    string createdAt;
    string modifiedAt;
}

struct DeploymentDTO {
    string id;
    string tenantId;
    string releaseId;
    string environmentId;
    string status;
    string startedAt;
    string finishedAt;
    string executedBy;
    string logUrl;
    string createdAt;
    string modifiedAt;
}

struct EnvironmentDTO {
    string id;
    string tenantId;
    string solutionId;
    string name;
    string environmentType;
    string region;
    string purpose;
    bool active;
    string createdAt;
    string modifiedAt;
}

struct AlertDTO {
    string id;
    string tenantId;
    string solutionId;
    string source;
    string severity;
    string status;
    string summary;
    string raisedAt;
    string acknowledgedBy;
    string resolvedAt;
    string createdAt;
    string modifiedAt;
}

struct AlmSummaryDTO {
    long totalSolutions;
    long totalProjects;
    long totalTasks;
    long openTasks;
    long totalTestPlans;
    long totalTestCases;
    long criticalDefects;
    long totalReleases;
    long activeDeployments;
    long openAlerts;
    long criticalAlerts;
    long readinessScore;
}
