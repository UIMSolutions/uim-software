/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.change_records;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageChangeRecordsUseCase : UIMUseCase {
    private ChangeRecordRepository repo;

    this(ChangeRecordRepository repo) { this.repo = repo; }

    ChangeRecord* get_(ChangeRecordId id) { return repo.findById(id); }
    ChangeRecord[] list() { return repo.findAll(); }
    ChangeRecord[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    ChangeRecord[] listByStatus(ChangeStatus status) { return repo.findByStatus(status); }
    ChangeRecord[] listByType(ChangeType changeType) { return repo.findByType(changeType); }
    ChangeRecord[] listByRisk(ChangeRisk risk) { return repo.findByRisk(risk); }

    CommandResult create(ChangeRecordDTO dto) {
        ChangeRecord c;
        c.id = dto.id;
        c.tenantId = dto.tenantId;
        c.title = dto.title;
        c.description = dto.description;
        c.requestedBy = dto.requestedBy;
        c.assignedTo = dto.assignedTo;
        c.scheduledStartDate = dto.scheduledStartDate;
        c.scheduledEndDate = dto.scheduledEndDate;
        c.implementationNotes = dto.implementationNotes;
        c.backoutPlan = dto.backoutPlan;
        c.createdBy = dto.createdBy;
        if (!ITILValidator.isValidChangeRecord(c))
            return CommandResult(false, "", "Invalid change record data");
        repo.save(c);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ChangeRecordDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Change record not found");
        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.implementationNotes.length > 0) existing.implementationNotes = dto.implementationNotes;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ChangeRecordId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Change record not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
