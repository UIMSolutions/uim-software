module uim.platform.ppm.infrastructure.persistence.repositories.programs;

import uim.platform.ppm;

@safe:

class MemoryProgramRepository : ProgramRepository {
    private Program[] items;

    Program[] findAll() { return items.dup; }

    Program* findById(ProgramId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }

    void save(Program value) { items ~= value; }

    void update(Program value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }

    void remove(ProgramId id) {
        Program[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
