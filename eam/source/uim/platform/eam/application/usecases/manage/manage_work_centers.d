/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.application.usecases.manage.manage_work_centers;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class ManageWorkCentersUseCase : UIMUseCase {
    private WorkCenterRepository repo;

    this(WorkCenterRepository repo) {
        this.repo = repo;
    }

    WorkCenter* get_(WorkCenterId id) {
        return repo.findById(id);
    }

    WorkCenter[] list() {
        return repo.findAll();
    }

    WorkCenter[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    WorkCenter[] listByCategory(WorkCenterCategory category) {
        return repo.findByCategory(category);
    }

    CommandResult create(WorkCenterDTO dto) {
        WorkCenter wc;
        wc.id = dto.id;
        wc.tenantId = dto.tenantId;
        wc.name = dto.name;
        wc.description = dto.description;
        wc.plantSection = dto.plantSection;
        wc.costCenter = dto.costCenter;
        wc.capacity = dto.capacity;
        wc.capacityUnit = dto.capacityUnit;
        wc.responsiblePerson = dto.responsiblePerson;
        wc.createdBy = dto.createdBy;
        if (!MaintenanceValidator.isValidWorkCenter(wc))
            return CommandResult(false, "", "Invalid work center data");
        repo.save(wc);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(WorkCenterDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Work center not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.capacity.length > 0) existing.capacity = dto.capacity;
        if (dto.responsiblePerson.length > 0) existing.responsiblePerson = dto.responsiblePerson;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(WorkCenterId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Work center not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
