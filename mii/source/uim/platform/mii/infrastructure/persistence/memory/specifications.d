module uim.platform.mii.infrastructure.persistence.memory.specifications;

import uim.platform.mii;

@safe:

class MemorySpecificationRepository : SpecificationRepository {
    private Specification[] items;

    Specification[] findAll() { return items.dup; }
    Specification* findById(SpecificationId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }
    void save(Specification value) { items ~= value; }
    void update(Specification value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }
    void remove(SpecificationId id) {
        Specification[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
