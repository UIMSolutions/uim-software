module uim.platform.defense.infrastructure.persistence.repositories.readiness_profiles;

import uim.platform.defense;

@safe:

class MemoryReadinessRepository : ReadinessRepository {
    private ReadinessProfile[] items;

    ReadinessProfile[] findAll() {
        return items.dup;
    }

    ReadinessProfile* findById(ReadinessProfileId id) {
        foreach (ref item; items) {
            if (item.id == id) return &item;
        }
        return null;
    }

    void save(ReadinessProfile profile) {
        items ~= profile;
    }

    void update(ReadinessProfile profile) {
        foreach (index, ref item; items) {
            if (item.id == profile.id) {
                items[index] = profile;
                return;
            }
        }
    }

    void remove(ReadinessProfileId id) {
        ReadinessProfile[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}