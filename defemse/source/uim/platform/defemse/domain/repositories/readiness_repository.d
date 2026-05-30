module uim.platform.defemse.domain.repositories.readiness_repository;

import uim.platform.defemse.domain.entities.readiness_profile;
import uim.platform.defemse.domain.types;

@safe:

interface ReadinessRepository {
    ReadinessProfile[] findAll();
    ReadinessProfile* findById(ReadinessProfileId id);
    void save(ReadinessProfile profile);
    void update(ReadinessProfile profile);
    void remove(ReadinessProfileId id);
}