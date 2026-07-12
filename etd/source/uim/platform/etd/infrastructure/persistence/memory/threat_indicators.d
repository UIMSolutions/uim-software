module uim.platform.etd.infrastructure.persistence.memory.threat_indicators;

import uim.platform.etd;

@safe:

class MemoryThreatIndicatorRepository : ThreatIndicatorRepository {
    private ThreatIndicator[] store;

    ThreatIndicator[] list() {
        return store.dup;
    }

    const(ThreatIndicator)* get_(string id) {
        foreach (idx, item; store) {
            if (item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    bool create(ThreatIndicator item) {
        if (get_(item.id) !is null) {
            return false;
        }
        store ~= item;
        return true;
    }

    bool update(ThreatIndicator item) {
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
