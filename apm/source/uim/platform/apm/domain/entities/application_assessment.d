module uim.platform.apm.domain.entities.application_assessment;

import uim.platform.apm.domain.types;

@safe:

struct ApplicationAssessment {
    AssessmentId id;
    TenantId tenantId;
    PortfolioItemId applicationId;
    string assessmentDate;
    string assessor;
    FitBand functionalFit = FitBand.moderate;
    FitBand technicalFit = FitBand.moderate;
    FitBand businessValue = FitBand.moderate;
    FitBand dataQuality = FitBand.moderate;
    long overallScore = 50;
    Recommendation recommendation = Recommendation.tolerate;
    string riskNotes;
    string nextReviewDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
