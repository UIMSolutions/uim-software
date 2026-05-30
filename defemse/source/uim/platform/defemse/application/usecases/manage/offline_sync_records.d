module uim.platform.defemse.application.usecases.manage.offline_sync_records;

import std.conv : to;
import uim.platform.defemse;

@safe:

class ManageOfflineSyncRecordsUseCase : UIMUseCase {
    private OfflineSyncRecordRepository repo;

    this(OfflineSyncRecordRepository repo) {
        this.repo = repo;
    }

    OfflineSyncRecord[] list() {
        return repo.findAll();
    }

    OfflineSyncRecord* get_(OfflineSyncRecordId id) {
        return repo.findById(id);
    }

    CommandResult create(OfflineSyncRecordDTO dto) {
        OfflineSyncRecord value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.recordType = dto.recordType;
        value.recordId = dto.recordId;
        value.action = dto.action;
        value.payload = dto.payload;
        if (dto.status.length > 0) value.status = dto.status.to!OfflineSyncStatus;
        value.lastSyncedAt = dto.lastSyncedAt;
        value.createdBy = dto.createdBy;
        if (!DefemseValidator.isValidOfflineSyncRecord(value))
            return CommandResult(false, "", "Invalid offline sync record data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(OfflineSyncRecordDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Offline sync record not found");
        if (dto.recordType.length > 0) existing.recordType = dto.recordType;
        if (dto.recordId.length > 0) existing.recordId = dto.recordId;
        if (dto.action.length > 0) existing.action = dto.action;
        if (dto.payload.length > 0) existing.payload = dto.payload;
        if (dto.status.length > 0) existing.status = dto.status.to!OfflineSyncStatus;
        if (dto.lastSyncedAt.length > 0) existing.lastSyncedAt = dto.lastSyncedAt;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(OfflineSyncRecordId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Offline sync record not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}