module uim.platform.maif.application.usecases.manage.manage_sync_jobs;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.maif;

@safe:

class ManageSyncJobsUseCase {
    private SyncJobRepository repo;

    this(SyncJobRepository repo) {
        this.repo = repo;
    }

    SyncJob[] list() {
        return repo.list();
    }

    const(SyncJob)* get_(string id) {
        return repo.get_(id);
    }

    CommandResult create(SyncJobDTO dto) {
        SyncJob value;
        value.id = dto.id.length ? dto.id : createCode("SYNC");
        value.tenantId = dto.tenantId;
        value.flowId = dto.flowId;
        value.triggerType = dto.triggerType;
        value.status = dto.status.length ? dto.status : "queued";
        value.startedAt = dto.startedAt;
        value.finishedAt = dto.finishedAt;
        value.recordsProcessed = dto.recordsProcessed;
        value.recordsFailed = dto.recordsFailed;
        value.lastError = dto.lastError;
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!MaifValidator.isValidSyncJob(value)) {
            return CommandResult(false, "", "Sync job flowId and triggerType are required");
        }

        if (!repo.create(value)) {
            return CommandResult(false, "", "Sync job already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(SyncJobDTO dto) {
        auto current = repo.get_(dto.id);
        if (current is null) {
            return CommandResult(false, "", "Sync job not found");
        }

        SyncJob value = *current;
        if (dto.flowId.length) value.flowId = dto.flowId;
        if (dto.triggerType.length) value.triggerType = dto.triggerType;
        if (dto.status.length) value.status = dto.status;
        if (dto.startedAt.length) value.startedAt = dto.startedAt;
        if (dto.finishedAt.length) value.finishedAt = dto.finishedAt;
        if (dto.recordsProcessed.length) value.recordsProcessed = dto.recordsProcessed;
        if (dto.recordsFailed.length) value.recordsFailed = dto.recordsFailed;
        if (dto.lastError.length) value.lastError = dto.lastError;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repo.update(value)) {
            return CommandResult(false, "", "Sync job not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!repo.remove(id)) {
            return CommandResult(false, "", "Sync job not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        return prefix ~ "-" ~ to!string(Clock.currTime().toUnixTime());
    }
}
