module uim.platform.defemse.domain.repositories.exercise_repository;

import uim.platform.defemse.domain.entities.exercise;
import uim.platform.defemse.domain.types;

@safe:

interface ExerciseRepository {
    Exercise[] findAll();
    Exercise* findById(ExerciseId id);
    void save(Exercise exercise);
    void update(Exercise exercise);
    void remove(ExerciseId id);
}