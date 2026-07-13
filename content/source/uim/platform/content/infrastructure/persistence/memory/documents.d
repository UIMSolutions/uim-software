module uim.platform.content.infrastructure.persistence.memory.documents;

import uim.platform.content;

@safe:

class MemoryDocumentRepository : DocumentRepository {
    private Document[] store;

    Document[] list() { return store.dup; }

    const(Document)* get_(string id) {
        foreach (idx, item; store) {
            if (item.id == id) return &store[idx];
        }
        return null;
    }

    bool create(Document value) {
        if (get_(value.id) !is null) return false;
        store ~= value;
        return true;
    }

    bool update(Document value) {
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
