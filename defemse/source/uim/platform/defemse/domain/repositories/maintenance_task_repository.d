module uim.platform.defemse.domain.repositories.maintenance_task_repository;

import uim.platform.defemse.domain.entities.maintenance_task;
import uim.platform.defemse.domain.types;

@safe:

interface MaintenanceTaskRepository {
    MaintenanceTask[] findAll();
    MaintenanceTask* findById(MaintenanceTaskId id);
    void save(MaintenanceTask task);
    void update(MaintenanceTask task);
    void remove(MaintenanceTaskId id);
}