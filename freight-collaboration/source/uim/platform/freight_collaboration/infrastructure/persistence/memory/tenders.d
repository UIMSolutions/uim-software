module uim.platform.freight_collaboration.infrastructure.persistence.memory.tenders;

import uim.platform.freight_collaboration;

@safe:

class MemoryTenderRepository : TenderRepository {
    private Tender[] items;

    Tender[] findAll() {
        return items.dup;
    }

    Tender* findById(TenderId id) @trusted {
        foreach (index, ref item; items) {
            if (item.id == id)
                return &items[index];
        }
        return null;
    }

    void save(Tender value) {
        items ~= value;
    }

    void update(Tender value) {
        foreach (index, ref item; items) {
            if (item.id == value.id) {
                items[index] = value;
                return;
            }
        }
    }

    void remove(TenderId id) {
        Tender[] next;
        foreach (item; items) {
            if (item.id != id)
                next ~= item;
        }
        items = next;
    }
}
