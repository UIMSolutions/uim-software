module uim.platform.team.infrastructure.persistence.repositories.documents;

import std.algorithm : remove;
import uim.platform.team;

@safe:

class MemoryDocumentRepository : DocumentRepository {
    private Document[] store;

    Document[] findAll() { return store; }

    Document[] findByTenant(TenantId tenantId) {
        Document[] result;
        foreach (item; store)
            if (item.tenantId == tenantId)
                result ~= item;
        return result;
    }

    Document* findById(DocumentId id) @trusted {
        foreach (idx, ref item; store)
            if (item.id == id)
                return &store[idx];
        return null;
    }

    Document[] findByPart(PartId partId) {
        Document[] result;
        foreach (item; store)
            if (item.relatedPartId == partId)
                result ~= item;
        return result;
    }

    Document[] findByChange(ChangeId changeId) {
        Document[] result;
        foreach (item; store)
            if (item.relatedChangeId == changeId)
                result ~= item;
        return result;
    }

    void save(Document document) { store ~= document; }

    void update(Document document) {
        foreach (ref item; store)
            if (item.id == document.id) {
                item = document;
                return;
            }
    }

    void remove(DocumentId id) {
        store = store.remove!(item => item.id == id);
    }
}
