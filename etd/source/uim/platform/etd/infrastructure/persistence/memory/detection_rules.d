module uim.platform.etd.infrastructure.persistence.repositories.detection_rules;

import uim.platform.etd;

@safe:

class MemoryDetectionRuleRepository : DetectionRuleRepository {
    private DetectionRule[] store;

    DetectionRule[] list() {
        return store.dup;
    }

    const(DetectionRule)* get_(string id) {
        foreach (idx, item; store) {
            if (item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    bool create(DetectionRule item) {
        if (get_(item.id) !is null) {
            return false;
        }
        store ~= item;
        return true;
    }

    bool update(DetectionRule item) {
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
