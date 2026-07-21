module uim.platform.defense.domain.repositories.mission_plans;

import uim.platform.defense.domain.entities.mission_plan;
import uim.platform.defense.domain.types;

@safe:

interface MissionPlanRepository {
    MissionPlan[] findAll();
    MissionPlan* findById(MissionPlanId id);
    void save(MissionPlan missionPlan);
    void update(MissionPlan missionPlan);
    void remove(MissionPlanId id);
}