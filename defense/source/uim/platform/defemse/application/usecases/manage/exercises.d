module uim.platform.defense.application.usecases.manage.exercises;

import std.conv : to;
import uim.platform.defense;

@safe:

class ManageExercisesUseCase : UIMUseCase {
    private ExerciseRepository repo;

    this(ExerciseRepository repo) {
        this.repo = repo;
    }

    Exercise[] list() {
        return repo.findAll();
    }

    Exercise* get_(ExerciseId id) {
        return repo.findById(id);
    }

    CommandResult create(ExerciseDTO dto) {
        Exercise value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.reference = dto.reference;
        value.name = dto.name;
        value.exerciseType = dto.exerciseType;
        value.exerciseScope = dto.exerciseScope;
        if (dto.status.length > 0) value.status = dto.status.to!ExerciseStatus;
        value.missionPlanId = dto.missionPlanId;
        value.plannedStart = dto.plannedStart;
        value.plannedEnd = dto.plannedEnd;
        value.contingencyLevel = dto.contingencyLevel;
        value.relocationRequired = dto.relocationRequired;
        value.locationId = dto.locationId;
        value.createdBy = dto.createdBy;
        if (!defenseValidator.isValidExercise(value))
            return CommandResult(false, "", "Invalid exercise data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ExerciseDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Exercise not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.exerciseType.length > 0) existing.exerciseType = dto.exerciseType;
        if (dto.exerciseScope.length > 0) existing.exerciseScope = dto.exerciseScope;
        if (dto.status.length > 0) existing.status = dto.status.to!ExerciseStatus;
        if (dto.missionPlanId.length > 0) existing.missionPlanId = dto.missionPlanId;
        if (dto.plannedStart.length > 0) existing.plannedStart = dto.plannedStart;
        if (dto.plannedEnd.length > 0) existing.plannedEnd = dto.plannedEnd;
        if (dto.contingencyLevel.length > 0) existing.contingencyLevel = dto.contingencyLevel;
        if (dto.relocationRequired.length > 0) existing.relocationRequired = dto.relocationRequired;
        if (dto.locationId.length > 0) existing.locationId = dto.locationId;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ExerciseId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Exercise not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}