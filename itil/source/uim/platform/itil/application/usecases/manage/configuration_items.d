/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_configuration_items;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageConfigurationItemsUseCase : UIMUseCase {
    private ConfigurationItemRepository repo;

    this(ConfigurationItemRepository repo) { this.repo = repo; }

    ConfigurationItem* get_(ConfigurationItemId id) { return repo.findById(id); }
    ConfigurationItem[] list() { return repo.findAll(); }
    ConfigurationItem[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    ConfigurationItem[] listByStatus(CIStatus ciStatus) { return repo.findByStatus(ciStatus); }
    ConfigurationItem[] listByType(CIType ciType) { return repo.findByType(ciType); }
    ConfigurationItem[] listByOwner(string ownerId) { return repo.findByOwner(ownerId); }

    CommandResult create(ConfigurationItemDTO dto) {
        ConfigurationItem ci;
        ci.id = dto.id;
        ci.tenantId = dto.tenantId;
        ci.name = dto.name;
        ci.description = dto.description;
        ci.version_ = dto.version_;
        ci.manufacturer = dto.manufacturer;
        ci.model = dto.model;
        ci.serialNumber = dto.serialNumber;
        ci.ipAddress = dto.ipAddress;
        ci.location = dto.location;
        ci.ownerId = dto.ownerId;
        ci.supportTeam = dto.supportTeam;
        ci.installedDate = dto.installedDate;
        ci.createdBy = dto.createdBy;
        if (!ITILValidator.isValidConfigurationItem(ci))
            return CommandResult(false, "", "Invalid configuration item data");
        repo.save(ci);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ConfigurationItemDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Configuration item not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.location.length > 0) existing.location = dto.location;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ConfigurationItemId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Configuration item not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
