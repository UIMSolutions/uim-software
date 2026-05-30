module uim.platform.defemse.domain.repositories.offline_sync_record_repository;

import uim.platform.defemse.domain.entities.offline_sync_record;
import uim.platform.defemse.domain.types;

@safe:

interface OfflineSyncRecordRepository {
    OfflineSyncRecord[] findAll();
    OfflineSyncRecord* findById(OfflineSyncRecordId id);
    void save(OfflineSyncRecord record);
    void update(OfflineSyncRecord record);
    void remove(OfflineSyncRecordId id);
}