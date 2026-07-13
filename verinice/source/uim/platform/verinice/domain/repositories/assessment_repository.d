module uim.platform.verinice.domain.repositories.assessment_repository;

import uim.platform.verinice.domain.entities.assessment;
import uim.platform.verinice.domain.types;

@safe:

interface AssessmentRepository {
    Assessment[] findAll();
    Assessment* findById(AssessmentId id);
    void save(Assessment value);
    void update(Assessment value);
    void remove(AssessmentId id);
}
