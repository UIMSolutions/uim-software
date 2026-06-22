module uim.platform.mii.infrastructure.persistence.memory.products;

import uim.platform.mii;

@safe:

class MemoryProductRepository : ProductRepository {
    private Product[] items;

    Product[] findAll() { return items.dup; }
    Product* findById(ProductId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }
    void save(Product value) { items ~= value; }
    void update(Product value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }
    void remove(ProductId id) {
        Product[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
