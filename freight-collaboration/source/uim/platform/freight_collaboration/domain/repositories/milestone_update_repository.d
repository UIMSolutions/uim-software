module uim.platform.freight_collaboration.domain.repositories.milestone_update_repository;

import uim.platform.freight_collaboration.domain.entities.milestone_update;
import uim.platform.freight_collaboration.domain.types;

@safe:

interface MilestoneUpdateRepository {
    MilestoneUpdate[] findAll();
    MilestoneUpdate* findById(MilestoneId id);
    void save(MilestoneUpdate value);
    void update(MilestoneUpdate value);
    void remove(MilestoneId id);
}
