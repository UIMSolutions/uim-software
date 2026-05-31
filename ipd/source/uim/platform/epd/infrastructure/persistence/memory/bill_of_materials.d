module uim.platform.epd.infrastructure.persistence.memory.bill_of_materials;

import uim.platform.epd;

@safe:

class MemoryBillOfMaterialRepository : BillOfMaterialRepository {
    private BillOfMaterial[] items;

    BillOfMaterial[] findAll() { return items.dup; }
    BillOfMaterial* findById(BillOfMaterialId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }
    void save(BillOfMaterial value) { items ~= value; }
    void update(BillOfMaterial value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }
    void remove(BillOfMaterialId id) {
        BillOfMaterial[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
