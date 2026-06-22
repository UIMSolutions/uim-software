module uim.platform.apm.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct PortfolioItemDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string businessCapability;
    string organization;
    string lifecyclePhase;
    string businessCriticality;
    string annualCostUsd;
    string owner;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct AssessmentDTO {
    string id;
    string tenantId;
    string applicationId;
    string assessmentDate;
    string assessor;
    string functionalFit;
    string technicalFit;
    string businessValue;
    string dataQuality;
    string overallScore;
    string recommendation;
    string riskNotes;
    string nextReviewDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct PortfolioMatrixPoint {
    string applicationId;
    string applicationName;
    string organization;
    string businessCapability;
    string businessCriticality;
    string functionalFit;
    string technicalFit;
    long overallScore;
    string recommendation;
}

struct PortfolioSummaryDTO {
    long totalApplications;
    long totalAssessments;
    long assessedApplications;
    long averageScore;
    long investCount;
    long tolerateCount;
    long migrateCount;
    long eliminateCount;
}
