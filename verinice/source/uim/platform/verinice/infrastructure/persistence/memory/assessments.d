module uim.platform.verinice.infrastructure.persistence.repositories.assessments;

import uim.platform.verinice;

@safe:

class MemoryAssessmentRepository : AssessmentRepository {
    private Assessment[] items;

    Assessment[] findAll() {
        return items.dup;
    }

    Assessment* findById(AssessmentId id) @trusted {
        foreach (index, ref item; items) {
            if (item.id == id)
                return &items[index];
        }
        return null;
    }

    void save(Assessment value) {
        items ~= value;
    }

    void update(Assessment value) {
        foreach (index, ref item; items) {
            if (item.id == value.id) {
                items[index] = value;
                return;
            }
        }
    }

    void remove(AssessmentId id) {
        Assessment[] next;
        foreach (item; items) {
            if (item.id != id)
                next ~= item;
        }
        items = next;
    }
}
