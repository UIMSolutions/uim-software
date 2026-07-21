module uim.platform.defense.domain.repositories.readiness;

import uim.platform.defense.domain.entities.readiness_profile;
import uim.platform.defense.domain.types;

@safe:

interface ReadinessRepository {
    ReadinessProfile[] findAll();
    ReadinessProfile* findById(ReadinessProfileId id);
    void save(ReadinessProfile profile);
    void update(ReadinessProfile profile);
    void remove(ReadinessProfileId id);
}