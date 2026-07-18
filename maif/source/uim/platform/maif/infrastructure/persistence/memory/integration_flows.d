module uim.platform.maif.infrastructure.persistence.repositories.integration_flows;

import uim.platform.maif;

@safe:

class MemoryIntegrationFlowRepository : IntegrationFlowRepository {
    private IntegrationFlow[] store;

    IntegrationFlow[] list() {
        return store.dup;
    }

    const(IntegrationFlow)* get_(string id) {
        foreach (idx, item; store) {
            if (item.id == id) {
                return &store[idx];
            }
        }
        return null;
    }

    bool create(IntegrationFlow value) {
        if (get_(value.id) !is null) {
            return false;
        }
        store ~= value;
        return true;
    }

    bool update(IntegrationFlow value) {
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
