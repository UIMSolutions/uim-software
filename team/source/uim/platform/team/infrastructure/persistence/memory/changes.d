module uim.platform.team.infrastructure.persistence.repositories.changes;

import std.algorithm : remove;
import uim.platform.team;

@safe:

class MemoryChangeRequestRepository : ChangeRequestRepository {
    private ChangeRequest[] store;

    ChangeRequest[] findAll() { return store; }

    ChangeRequest[] findByTenant(TenantId tenantId) {
        ChangeRequest[] result;
        foreach (item; store)
            if (item.tenantId == tenantId)
                result ~= item;
        return result;
    }

    ChangeRequest* findById(ChangeId id) @trusted {
        foreach (idx, ref item; store)
            if (item.id == id)
                return &store[idx];
        return null;
    }

    ChangeRequest[] findByPart(PartId partId) {
        ChangeRequest[] result;
        foreach (item; store)
            foreach (affected; item.affectedPartIds)
                if (affected == partId) {
                    result ~= item;
                    break;
                }
        return result;
    }

    void save(ChangeRequest changeRequest) { store ~= changeRequest; }

    void update(ChangeRequest changeRequest) {
        foreach (ref item; store)
            if (item.id == changeRequest.id) {
                item = changeRequest;
                return;
            }
    }

    void remove(ChangeId id) {
        store = store.remove!(item => item.id == id);
    }
}
