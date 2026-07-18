module uim.platform.defemse.infrastructure.persistence.repositories.exercises;

import uim.platform.defemse;

@safe:

class MemoryExerciseRepository : ExerciseRepository {
    private Exercise[] items;

    Exercise[] findAll() {
        return items.dup;
    }

    Exercise* findById(ExerciseId id) {
        foreach (ref item; items) {
            if (item.id == id) return &item;
        }
        return null;
    }

    void save(Exercise exercise) {
        items ~= exercise;
    }

    void update(Exercise exercise) {
        foreach (index, ref item; items) {
            if (item.id == exercise.id) {
                items[index] = exercise;
                return;
            }
        }
    }

    void remove(ExerciseId id) {
        Exercise[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}