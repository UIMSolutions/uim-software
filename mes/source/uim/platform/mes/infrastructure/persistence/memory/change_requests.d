module uim.platform.mes.infrastructure.persistence.memory.change_requests;

import uim.platform.mes;

@safe:

class MemoryChangeRequestRepository : ChangeRequestRepository {
    private ChangeRequest[] items;

    ChangeRequest[] findAll() { return items.dup; }
    ChangeRequest* findById(ChangeRequestId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }
    void save(ChangeRequest value) { items ~= value; }
    void update(ChangeRequest value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }
    void remove(ChangeRequestId id) {
        ChangeRequest[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
