module uim.platform.mes.infrastructure.persistence.repositories.specifications;

import uim.platform.mes;

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
