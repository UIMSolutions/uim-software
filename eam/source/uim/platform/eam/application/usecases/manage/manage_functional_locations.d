/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.application.usecases.manage.manage_functional_locations;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class ManageFunctionalLocationsUseCase : UIMUseCase {
    private FunctionalLocationRepository repo;

    this(FunctionalLocationRepository repo) {
        this.repo = repo;
    }

    FunctionalLocation* get_(FunctionalLocationId id) {
        return repo.findById(id);
    }

    FunctionalLocation[] list() {
        return repo.findAll();
    }

    FunctionalLocation[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    FunctionalLocation[] listByType(FunctionalLocationType locationType) {
        return repo.findByType(locationType);
    }

    FunctionalLocation[] listByParent(FunctionalLocationId parentId) {
        return repo.findByParent(parentId);
    }

    CommandResult create(FunctionalLocationDTO dto) {
        FunctionalLocation fl;
        fl.id = dto.id;
        fl.tenantId = dto.tenantId;
        fl.name = dto.name;
        fl.description = dto.description;
        fl.locationLabel = dto.locationLabel;
        fl.parentLocationId = dto.parentLocationId;
        fl.plantSection = dto.plantSection;
        fl.costCenter = dto.costCenter;
        fl.address = dto.address;
        fl.createdBy = dto.createdBy;
        if (!MaintenanceValidator.isValidFunctionalLocation(fl))
            return CommandResult(false, "", "Invalid functional location data");
        repo.save(fl);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(FunctionalLocationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Functional location not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.address.length > 0) existing.address = dto.address;
        if (dto.costCenter.length > 0) existing.costCenter = dto.costCenter;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(FunctionalLocationId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Functional location not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
