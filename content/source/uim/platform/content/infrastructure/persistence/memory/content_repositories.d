module uim.platform.content.infrastructure.persistence.repositories.content_repositories;

import uim.platform.content;

@safe:

class MemoryContentRepositoryRepository : ContentRepositoryRepository {
    private ContentRepository[] store;

    ContentRepository[] list() { return store.dup; }

    const(ContentRepository)* get_(string id) {
        foreach (idx, item; store) {
            if (item.id == id) return &store[idx];
        }
        return null;
    }

    bool create(ContentRepository value) {
        if (get_(value.id) !is null) return false;
        store ~= value;
        return true;
    }

    bool update(ContentRepository value) {
        foreach (idx, item; store) {
            if (item.id == value.id) {
                store[idx] = value;
                return true;
            }
        }
        return false;
    }

    bool remove(string id) {
        foreach (idx, item; store) {
            if (item.id == id) {
                store = store[0 .. idx] ~ store[idx + 1 .. $];
                return true;
            }
        }
        return false;
    }
}
