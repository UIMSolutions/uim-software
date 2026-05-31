module uim.platform.mes.domain.repositories.collaboration_repository;

import uim.platform.mes.domain.entities.collaboration;
import uim.platform.mes.domain.types;

@safe:

interface CollaborationRepository {
    Collaboration[] findAll();
    Collaboration* findById(CollaborationId id);
    void save(Collaboration value);
    void update(Collaboration value);
    void remove(CollaborationId id);
}