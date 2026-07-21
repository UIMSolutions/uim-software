module uim.platform.defense.domain.repositories.offline_sync_records
;

import uim.platform.defense.domain.entities.offline_sync_record;
import uim.platform.defense.domain.types;

@safe:

interface OfflineSyncRecordRepository {
    OfflineSyncRecord[] findAll();
    OfflineSyncRecord* findById(OfflineSyncRecordId id);
    void save(OfflineSyncRecord record);
    void update(OfflineSyncRecord record);
    void remove(OfflineSyncRecordId id);
}