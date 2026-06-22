module uim.platform.ppm.infrastructure.persistence.memory.initiatives;

import uim.platform.ppm;

@safe:

class MemoryInitiativeRepository : InitiativeRepository {
    private Initiative[] items;

    Initiative[] findAll() { return items.dup; }

    Initiative* findById(InitiativeId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }

    void save(Initiative value) { items ~= value; }

    void update(Initiative value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }

    void remove(InitiativeId id) {
        Initiative[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
