module uim.platform.maif.domain.repositories.sync_job_repository;

import uim.platform.maif.domain.entities.sync_job;

@safe:

interface SyncJobRepository {
    SyncJob[] list();
    const(SyncJob)* get_(string id);
    bool create(SyncJob value);
    bool update(SyncJob value);
    bool remove(string id);
}
