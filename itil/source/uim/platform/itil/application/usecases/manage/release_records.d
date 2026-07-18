/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_release_records;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageReleaseRecordsUseCase : UIMUseCase {
    private ReleaseRecordRepository repo;

    this(ReleaseRecordRepository repo) { this.repo = repo; }

    ReleaseRecord* get_(ReleaseRecordId id) { return repo.findById(id); }
    ReleaseRecord[] list() { return repo.findAll(); }
    ReleaseRecord[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    ReleaseRecord[] listByStatus(ReleaseStatus status) { return repo.findByStatus(status); }
    ReleaseRecord[] listByType(ReleaseType releaseType) { return repo.findByType(releaseType); }

    CommandResult create(ReleaseRecordDTO dto) {
        ReleaseRecord r;
        r.id = dto.id;
        r.tenantId = dto.tenantId;
        r.name = dto.name;
        r.description = dto.description;
        r.version_ = dto.version_;
        r.targetDate = dto.targetDate;
        r.deployedBy = dto.deployedBy;
        r.testPlan = dto.testPlan;
        r.deploymentPlan = dto.deploymentPlan;
        r.backoutPlan = dto.backoutPlan;
        r.createdBy = dto.createdBy;
        if (!ITILValidator.isValidReleaseRecord(r))
            return CommandResult(false, "", "Invalid release record data");
        repo.save(r);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ReleaseRecordDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Release record not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.targetDate.length > 0) existing.targetDate = dto.targetDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ReleaseRecordId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Release record not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
