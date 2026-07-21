module uim.platform.defense.infrastructure.persistence.repositories.contingents;

import uim.platform.defense;

@safe:

class MemoryContingentRepository : ContingentRepository {
    private Contingent[] items;

    Contingent[] findAll() {
        return items.dup;
    }

    Contingent* findById(ContingentId id) {
        foreach (ref item; items) {
            if (item.id == id) return &item;
        }
        return null;
    }

    void save(Contingent contingent) {
        items ~= contingent;
    }

    void update(Contingent contingent) {
        foreach (index, ref item; items) {
            if (item.id == contingent.id) {
                items[index] = contingent;
                return;
            }
        }
    }

    void remove(ContingentId id) {
        Contingent[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}