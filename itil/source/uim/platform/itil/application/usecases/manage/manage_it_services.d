/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_it_services;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageITServicesUseCase : UIMUseCase {
    private ITServiceRepository repo;

    this(ITServiceRepository repo) { this.repo = repo; }

    ITService* get_(ITServiceId id) { return repo.findById(id); }
    ITService[] list() { return repo.findAll(); }
    ITService[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    ITService[] listByStatus(RecordStatus status) { return repo.findByStatus(status); }
    ITService[] listByOwner(string owner) { return repo.findByOwner(owner); }

    CommandResult create(ITServiceDTO dto) {
        ITService s;
        s.id = dto.id;
        s.tenantId = dto.tenantId;
        s.name = dto.name;
        s.description = dto.description;
        s.serviceOwner = dto.serviceOwner;
        s.serviceManager = dto.serviceManager;
        s.supportTeam = dto.supportTeam;
        s.serviceLevel = dto.serviceLevel;
        s.category = dto.category;
        s.createdBy = dto.createdBy;
        if (!ITILValidator.isValidITService(s))
            return CommandResult(false, "", "Invalid IT service data");
        repo.save(s);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ITServiceDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "IT service not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.serviceOwner.length > 0) existing.serviceOwner = dto.serviceOwner;
        if (dto.serviceLevel.length > 0) existing.serviceLevel = dto.serviceLevel;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ITServiceId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "IT service not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
