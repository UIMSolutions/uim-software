module uim.platform.ewm.domain.repositories.collaboration_repository;

import uim.platform.ewm.domain.entities.collaboration;
import uim.platform.ewm.domain.types;

@safe:

interface CollaborationRepository {
    Collaboration[] findAll();
    Collaboration* findById(CollaborationId id);
    void save(Collaboration value);
    void update(Collaboration value);
    void remove(CollaborationId id);
}