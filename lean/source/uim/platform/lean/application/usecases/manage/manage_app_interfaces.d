/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_app_interfaces;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageAppInterfacesUseCase : UIMUseCase {
    private AppInterfaceRepository repo;

    this(AppInterfaceRepository repo) { this.repo = repo; }

    AppInterface* get_(AppInterfaceId id) { return repo.findById(id); }
    AppInterface[] list() { return repo.findAll(); }
    AppInterface[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    AppInterface[] listBySource(LeanApplicationId appId) { return repo.findBySourceApplication(appId); }
    AppInterface[] listByTarget(LeanApplicationId appId) { return repo.findByTargetApplication(appId); }

    CommandResult create(AppInterfaceDTO dto) {
        AppInterface ai;
        ai.id = dto.id;
        ai.tenantId = dto.tenantId;
        ai.name = dto.name;
        ai.description = dto.description;
        ai.sourceApplicationId = dto.sourceApplicationId;
        ai.targetApplicationId = dto.targetApplicationId;
        ai.protocol = dto.protocol;
        ai.dataFormat = dto.dataFormat;
        ai.dataObjectId = dto.dataObjectId;
        ai.createdBy = dto.createdBy;
        if (!LeanValidator.isValidAppInterface(ai))
            return CommandResult(false, "", "Invalid interface data");
        repo.save(ai);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(AppInterfaceDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Interface not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.protocol.length > 0) existing.protocol = dto.protocol;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(AppInterfaceId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Interface not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
