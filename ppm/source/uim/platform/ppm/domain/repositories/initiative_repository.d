module uim.platform.ppm.domain.repositories.initiative_repository;

import uim.platform.ppm.domain.entities.initiative;
import uim.platform.ppm.domain.types;

@safe:

interface InitiativeRepository {
    Initiative[] findAll();
    Initiative* findById(InitiativeId id);
    void save(Initiative value);
    void update(Initiative value);
    void remove(InitiativeId id);
}
