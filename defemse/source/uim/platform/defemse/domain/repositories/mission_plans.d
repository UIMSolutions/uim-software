module uim.platform.defemse.domain.repositories.mission_plans;

import uim.platform.defemse.domain.entities.mission_plan;
import uim.platform.defemse.domain.types;

@safe:

interface MissionPlanRepository {
    MissionPlan[] findAll();
    MissionPlan* findById(MissionPlanId id);
    void save(MissionPlan missionPlan);
    void update(MissionPlan missionPlan);
    void remove(MissionPlanId id);
}