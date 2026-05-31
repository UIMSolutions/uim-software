module uim.platform.mes.infrastructure.persistence.memory.documents;

import uim.platform.mes;

@safe:

class MemoryDocumentRepository : DocumentRepository {
    private Document[] items;

    Document[] findAll() { return items.dup; }
    Document* findById(DocumentId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }
    void save(Document value) { items ~= value; }
    void update(Document value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }
    void remove(DocumentId id) {
        Document[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
