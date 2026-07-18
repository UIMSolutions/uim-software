module uim.platform.freight_collaboration.infrastructure.persistence.repositories.milestones;

import uim.platform.freight_collaboration;

@safe:

class MemoryMilestoneRepository : MilestoneUpdateRepository {
    private MilestoneUpdate[] items;

    MilestoneUpdate[] findAll() {
        return items.dup;
    }

    MilestoneUpdate* findById(MilestoneId id) @trusted {
        foreach (index, ref item; items) {
            if (item.id == id)
                return &items[index];
        }
        return null;
    }

    void save(MilestoneUpdate value) {
        items ~= value;
    }

    void update(MilestoneUpdate value) {
        foreach (index, ref item; items) {
            if (item.id == value.id) {
                items[index] = value;
                return;
            }
        }
    }

    void remove(MilestoneId id) {
        MilestoneUpdate[] next;
        foreach (item; items) {
            if (item.id != id)
                next ~= item;
        }
        items = next;
    }
}
