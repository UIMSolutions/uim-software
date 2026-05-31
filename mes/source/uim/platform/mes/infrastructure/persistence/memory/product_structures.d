module uim.platform.mes.infrastructure.persistence.memory.product_structures;

import uim.platform.mes;

@safe:

class MemoryProductStructureRepository : ProductStructureRepository {
    private ProductStructure[] items;

    ProductStructure[] findAll() { return items.dup; }
    ProductStructure* findById(ProductStructureId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }
    void save(ProductStructure value) { items ~= value; }
    void update(ProductStructure value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }
    void remove(ProductStructureId id) {
        ProductStructure[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
