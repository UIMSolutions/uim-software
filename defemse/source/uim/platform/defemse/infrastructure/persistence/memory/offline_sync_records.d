module uim.platform.defemse.infrastructure.persistence.repositories.offline_sync_records;

import uim.platform.defemse;

@safe:

class MemoryOfflineSyncRecordRepository : OfflineSyncRecordRepository {
    private OfflineSyncRecord[] items;

    OfflineSyncRecord[] findAll() { return items.dup; }

    OfflineSyncRecord* findById(OfflineSyncRecordId id) {
        foreach (ref item; items) if (item.id == id) return &item;
        return null;
    }

    void save(OfflineSyncRecord record) { items ~= record; }

    void update(OfflineSyncRecord record) {
        foreach (index, ref item; items) if (item.id == record.id) { items[index] = record; return; }
    }

    void remove(OfflineSyncRecordId id) {
        OfflineSyncRecord[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}