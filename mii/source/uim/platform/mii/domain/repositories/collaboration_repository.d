module uim.platform.mii.domain.repositories.collaboration_repository;

import uim.platform.mii.domain.entities.collaboration;
import uim.platform.mii.domain.types;

@safe:

interface CollaborationRepository {
    Collaboration[] findAll();
    Collaboration* findById(CollaborationId id);
    void save(Collaboration value);
    void update(Collaboration value);
    void remove(CollaborationId id);
}