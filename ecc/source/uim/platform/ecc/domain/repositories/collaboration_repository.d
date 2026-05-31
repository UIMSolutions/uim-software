module uim.platform.ecc.domain.repositories.collaboration_repository;

import uim.platform.ecc.domain.entities.collaboration;
import uim.platform.ecc.domain.types;

@safe:

interface CollaborationRepository {
    Collaboration[] findAll();
    Collaboration* findById(CollaborationId id);
    void save(Collaboration value);
    void update(Collaboration value);
    void remove(CollaborationId id);
}