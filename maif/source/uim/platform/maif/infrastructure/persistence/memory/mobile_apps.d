module uim.platform.maif.infrastructure.persistence.repositories.mobile_apps;

import uim.platform.maif;

@safe:

class MemoryMobileAppRepository : MobileAppRepository {
    private MobileApp[] store;

    MobileApp[] list() {
        return store.dup;
    }

    const(MobileApp)* get_(string id) {
        foreach (idx, item; store) {
            if (item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    bool create(MobileApp value) {
        if (get_(value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    bool update(MobileApp value) {
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
