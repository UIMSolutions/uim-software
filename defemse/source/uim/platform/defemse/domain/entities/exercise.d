module uim.platform.defemse.domain.entities.exercise;

import uim.platform.defemse.domain.types;

@safe:

struct Exercise {
    ExerciseId id;
    TenantId tenantId;
    string reference;
    string name;
    string exerciseType;
    string exerciseScope;
    ExerciseStatus status = ExerciseStatus.planned;
    string missionPlanId;
    string plannedStart;
    string plannedEnd;
    string contingencyLevel;
    string relocationRequired;
    string locationId;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}