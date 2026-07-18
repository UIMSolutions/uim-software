module uim.platform.ppm.infrastructure.persistence.repositories.projects;

import uim.platform.ppm;

@safe:

class MemoryProjectRepository : ProjectRepository {
    private Project[] items;

    Project[] findAll() { return items.dup; }

    Project* findById(ProjectId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }

    void save(Project value) { items ~= value; }

    void update(Project value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }

    void remove(ProjectId id) {
        Project[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
