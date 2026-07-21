module uim.platform.defense.domain.repositories.maintenance_tasks;

import uim.platform.defense.domain.entities.maintenance_task;
import uim.platform.defense.domain.types;

@safe:

interface MaintenanceTaskRepository {
    MaintenanceTask[] findAll();
    MaintenanceTask* findById(MaintenanceTaskId id);
    void save(MaintenanceTask task);
    void update(MaintenanceTask task);
    void remove(MaintenanceTaskId id);
}