module uim.platform.defemse.infrastructure.persistence.repositories.mission_plans;

import uim.platform.defemse;

@safe:

class MemoryMissionPlanRepository : MissionPlanRepository {
    private MissionPlan[] items;

    MissionPlan[] findAll() {
        return items.dup;
    }

    MissionPlan* findById(MissionPlanId id) {
        foreach (ref item; items) {
            if (item.id == id) return &item;
        }
        return null;
    }

    void save(MissionPlan missionPlan) {
        items ~= missionPlan;
    }

    void update(MissionPlan missionPlan) {
        foreach (index, ref item; items) {
            if (item.id == missionPlan.id) {
                items[index] = missionPlan;
                return;
            }
        }
    }

    void remove(MissionPlanId id) {
        MissionPlan[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}