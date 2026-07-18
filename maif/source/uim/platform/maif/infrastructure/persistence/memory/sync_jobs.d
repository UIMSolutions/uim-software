module uim.platform.maif.infrastructure.persistence.repositories.sync_jobs;

import uim.platform.maif;

@safe:

class MemorySyncJobRepository : SyncJobRepository {
    private SyncJob[] store;

    SyncJob[] list() {
        return store.dup;
    }

    const(SyncJob)* get_(string id) {
        foreach (idx, item; store) {
            if (item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    bool create(SyncJob value) {
        if (get_(value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    bool update(SyncJob value) {
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
