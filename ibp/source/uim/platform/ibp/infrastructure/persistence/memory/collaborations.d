module uim.platform.ibp.infrastructure.persistence.repositories.collaborations;

import uim.platform.ibp;

@safe:

class MemoryCollaborationRepository : CollaborationRepository {
    private Collaboration[] items;

    Collaboration[] findAll() { return items.dup; }
    Collaboration* findById(CollaborationId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }
    void save(Collaboration value) { items ~= value; }
    void update(Collaboration value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }
    void remove(CollaborationId id) {
        Collaboration[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
