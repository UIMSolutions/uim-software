module uim.platform.apm.infrastructure.persistence.repositories.assessments;

import std.algorithm : remove;
import uim.platform.apm;

@safe:

class MemoryAssessmentRepository : AssessmentRepository {
    private ApplicationAssessment[] store;

    ApplicationAssessment[] findAll() { return store; }

    ApplicationAssessment[] findByTenant(TenantId tenantId) {
        ApplicationAssessment[] result;
        foreach (assessment; store) {
            if (assessment.tenantId == tenantId)
                result ~= assessment;
        }
        return result;
    }

    ApplicationAssessment[] findByApplication(PortfolioItemId applicationId) {
        ApplicationAssessment[] result;
        foreach (assessment; store) {
            if (assessment.applicationId == applicationId)
                result ~= assessment;
        }
        return result;
    }

    ApplicationAssessment* findById(AssessmentId id) @trusted {
        foreach (idx, ref assessment; store) {
            if (assessment.id == id)
                return &store[idx];
        }
        return null;
    }

    void save(ApplicationAssessment assessment) { store ~= assessment; }

    void update(ApplicationAssessment assessment) {
        foreach (ref current; store) {
            if (current.id == assessment.id) {
                current = assessment;
                return;
            }
        }
    }

    void remove(AssessmentId id) {
        store = store.remove!(assessment => assessment.id == id);
    }
}
