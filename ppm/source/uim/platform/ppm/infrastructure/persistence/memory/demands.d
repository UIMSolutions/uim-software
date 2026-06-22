module uim.platform.ppm.infrastructure.persistence.memory.demands;

import uim.platform.ppm;

@safe:

class MemoryDemandRepository : DemandRepository {
    private Demand[] items;

    Demand[] findAll() { return items.dup; }

    Demand* findById(DemandId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }

    void save(Demand value) { items ~= value; }

    void update(Demand value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }

    void remove(DemandId id) {
        Demand[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
