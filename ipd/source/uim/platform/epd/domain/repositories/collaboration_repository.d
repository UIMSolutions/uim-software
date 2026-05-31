module uim.platform.epd.domain.repositories.collaboration_repository;

import uim.platform.epd.domain.entities.collaboration;
import uim.platform.epd.domain.types;

@safe:

interface CollaborationRepository {
    Collaboration[] findAll();
    Collaboration* findById(CollaborationId id);
    void save(Collaboration value);
    void update(Collaboration value);
    void remove(CollaborationId id);
}