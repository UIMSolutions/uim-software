module uim.platform.plm.domain.repositories.collaboration_repository;

import uim.platform.plm.domain.entities.collaboration;
import uim.platform.plm.domain.types;

@safe:

interface CollaborationRepository {
    Collaboration[] findAll();
    Collaboration* findById(CollaborationId id);
    void save(Collaboration value);
    void update(Collaboration value);
    void remove(CollaborationId id);
}