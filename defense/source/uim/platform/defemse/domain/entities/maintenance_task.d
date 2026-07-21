module uim.platform.defense.domain.entities.maintenance_task;

import uim.platform.defense.domain.types;

@safe:

struct MaintenanceTask {
    MaintenanceTaskId id;
    TenantId tenantId;
    ContingentId contingentId;
    string equipmentId;
    string taskType;
    string priority;
    string dueAt;
    MaintenanceTaskStatus status = MaintenanceTaskStatus.planned;
    string locationId;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}