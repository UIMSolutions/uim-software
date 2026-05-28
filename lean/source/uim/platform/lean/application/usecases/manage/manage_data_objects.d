/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_data_objects;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageDataObjectsUseCase : UIMUseCase {
    private DataObjectRepository repo;

    this(DataObjectRepository repo) { this.repo = repo; }

    DataObject* get_(DataObjectId id) { return repo.findById(id); }
    DataObject[] list() { return repo.findAll(); }
    DataObject[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    DataObject[] listByClassification(DataClassification classification) { return repo.findByClassification(classification); }
    DataObject[] listByApplication(LeanApplicationId appId) { return repo.findByApplication(appId); }

    CommandResult create(DataObjectDTO dto) {
        DataObject d;
        d.id = dto.id;
        d.tenantId = dto.tenantId;
        d.name = dto.name;
        d.description = dto.description;
        d.owningApplicationId = dto.owningApplicationId;
        d.dataFormat = dto.dataFormat;
        d.retentionPeriodDays = dto.retentionPeriodDays;
        d.gdprBasis = dto.gdprBasis;
        d.createdBy = dto.createdBy;
        if (!LeanValidator.isValidDataObject(d))
            return CommandResult(false, "", "Invalid data object");
        repo.save(d);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(DataObjectDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Data object not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.dataFormat.length > 0) existing.dataFormat = dto.dataFormat;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(DataObjectId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Data object not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
