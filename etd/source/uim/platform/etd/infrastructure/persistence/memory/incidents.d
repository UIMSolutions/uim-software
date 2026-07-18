module uim.platform.etd.infrastructure.persistence.repositories.incidents;

import uim.platform.etd;

@safe:

class MemoryIncidentRepository : IncidentRepository {
    private Incident[] store;

    Incident[] list() {
        return store.dup;
    }

    const(Incident)* get_(string id) {
        foreach (idx, item; store) {
            if (item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    bool create(Incident item) {
        if (get_(item.id) !is null) {
            return false;
        }
        store ~= item;
        return true;
    }

    bool update(Incident item) {
        foreach (idx, current; store) {
            if (current.id == item.id) {
                store[idx] = item;
                return true;
            }
        }
        return false;
    }

    bool remove(string id) {
        foreach (idx, current; store) {
            if (current.id == id) {
                store = store[0 .. idx] ~ store[idx + 1 .. $];
                return true;
            }
        }
        return false;
    }
}
