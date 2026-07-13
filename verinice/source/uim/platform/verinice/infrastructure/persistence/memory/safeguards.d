module uim.platform.verinice.infrastructure.persistence.memory.safeguards;

import uim.platform.verinice;

@safe:

class MemorySafeguardRepository : SafeguardRepository {
    private Safeguard[] items;

    Safeguard[] findAll() {
        return items.dup;
    }

    Safeguard* findById(SafeguardId id) @trusted {
        foreach (index, ref item; items) {
            if (item.id == id)
                return &items[index];
        }
        return null;
    }

    void save(Safeguard value) {
        items ~= value;
    }

    void update(Safeguard value) {
        foreach (index, ref item; items) {
            if (item.id == value.id) {
                items[index] = value;
                return;
            }
        }
    }

    void remove(SafeguardId id) {
        Safeguard[] next;
        foreach (item; items) {
            if (item.id != id)
                next ~= item;
        }
        items = next;
    }
}
