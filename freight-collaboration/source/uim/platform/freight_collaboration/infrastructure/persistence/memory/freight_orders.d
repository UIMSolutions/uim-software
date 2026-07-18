module uim.platform.freight_collaboration.infrastructure.persistence.repositories.freight_orders;

import uim.platform.freight_collaboration;

@safe:

class MemoryFreightOrderRepository : FreightOrderRepository {
    private FreightOrder[] items;

    FreightOrder[] findAll() {
        return items.dup;
    }

    FreightOrder* findById(FreightOrderId id) @trusted {
        foreach (index, ref item; items) {
            if (item.id == id)
                return &items[index];
        }
        return null;
    }

    void save(FreightOrder value) {
        items ~= value;
    }

    void update(FreightOrder value) {
        foreach (index, ref item; items) {
            if (item.id == value.id) {
                items[index] = value;
                return;
            }
        }
    }

    void remove(FreightOrderId id) {
        FreightOrder[] next;
        foreach (item; items) {
            if (item.id != id)
                next ~= item;
        }
        items = next;
    }
}
