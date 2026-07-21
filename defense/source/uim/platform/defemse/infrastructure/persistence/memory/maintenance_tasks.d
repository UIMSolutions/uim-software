module uim.platform.defense.infrastructure.persistence.repositories.maintenance_tasks;

import uim.platform.defense;

@safe:

class MemoryMaintenanceTaskRepository : MaintenanceTaskRepository {
    private MaintenanceTask[] items;

    MaintenanceTask[] findAll() { return items.dup; }

    MaintenanceTask* findById(MaintenanceTaskId id) {
        foreach (ref item; items) if (item.id == id) return &item;
        return null;
    }

    void save(MaintenanceTask task) { items ~= task; }

    void update(MaintenanceTask task) {
        foreach (index, ref item; items) if (item.id == task.id) { items[index] = task; return; }
    }

    void remove(MaintenanceTaskId id) {
        MaintenanceTask[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}