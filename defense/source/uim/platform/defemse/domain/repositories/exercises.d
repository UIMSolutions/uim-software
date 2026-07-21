module uim.platform.defense.domain.repositories.exercises;

import uim.platform.defense.domain.entities.exercise;
import uim.platform.defense.domain.types;

@safe:

interface ExerciseRepository {
    Exercise[] findAll();
    Exercise* findById(ExerciseId id);
    void save(Exercise exercise);
    void update(Exercise exercise);
    void remove(ExerciseId id);
}