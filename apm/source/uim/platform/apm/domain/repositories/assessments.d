module uim.platform.apm.domain.repositories.assessments;

import uim.platform.apm.domain;

@safe:

interface AssessmentRepository {
    ApplicationAssessment[] findAll();
    ApplicationAssessment[] findByTenant(TenantId tenantId);
    ApplicationAssessment[] findByApplication(PortfolioItemId applicationId);
    ApplicationAssessment* findById(AssessmentId id);
    void save(ApplicationAssessment assessment);
    void update(ApplicationAssessment assessment);
    void remove(AssessmentId id);
}
