module uim.platform.maif.domain.entities.sync_job;

@safe:

struct SyncJob {
    string id;
    string tenantId;
    string flowId;
    string triggerType;
    string status;
    string startedAt;
    string finishedAt;
    string recordsProcessed;
    string recordsFailed;
    string lastError;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
