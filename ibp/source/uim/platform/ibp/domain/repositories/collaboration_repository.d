module uim.platform.ibp.domain.repositories.collaboration_repository;

import uim.platform.ibp.domain.entities.collaboration;
import uim.platform.ibp.domain.types;

@safe:

interface CollaborationRepository {
    Collaboration[] findAll();
    Collaboration* findById(CollaborationId id);
    void save(Collaboration value);
    void update(Collaboration value);
    void remove(CollaborationId id);
}