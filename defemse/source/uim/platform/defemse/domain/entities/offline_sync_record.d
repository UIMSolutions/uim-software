module uim.platform.defemse.domain.entities.offline_sync_record;

import uim.platform.defemse.domain.types;

@safe:

struct OfflineSyncRecord {
    OfflineSyncRecordId id;
    TenantId tenantId;
    string recordType;
    string recordId;
    string action;
    string payload;
    OfflineSyncStatus status = OfflineSyncStatus.pending;
    string lastSyncedAt;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}