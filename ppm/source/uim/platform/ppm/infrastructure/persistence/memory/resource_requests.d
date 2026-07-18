module uim.platform.ppm.infrastructure.persistence.repositories.resource_requests;

import uim.platform.ppm;

@safe:

class MemoryResourceRequestRepository : ResourceRequestRepository {
    private ResourceRequest[] items;

    ResourceRequest[] findAll() { return items.dup; }

    ResourceRequest* findById(ResourceRequestId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }

    void save(ResourceRequest value) { items ~= value; }

    void update(ResourceRequest value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }

    void remove(ResourceRequestId id) {
        ResourceRequest[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
