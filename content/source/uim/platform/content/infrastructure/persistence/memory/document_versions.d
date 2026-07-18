module uim.platform.content.infrastructure.persistence.repositories.document_versions;

import uim.platform.content;

@safe:

class MemoryDocumentVersionRepository : DocumentVersionRepository {
    private DocumentVersion[] store;

    DocumentVersion[] listByDocumentId(string documentId) {
        DocumentVersion[] result;
        foreach (item; store) {
            if (item.documentId == documentId) result ~= item;
        }
        return result;
    }

    const(DocumentVersion)* get_(string id) {
        foreach (idx, item; store) {
            if (item.id == id) return &store[idx];
        }
        return null;
    }

    bool create(DocumentVersion value) {
        if (get_(value.id) !is null) return false;
        store ~= value;
        return true;
    }

    bool update(DocumentVersion value) {
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
