/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.application.usecases.manage.manage_instances;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class ManageInstancesUseCase : UIMUseCase {
    private InstanceRepository repo;

    this(InstanceRepository repo) {
        this.repo = repo;
    }

    Instance* get_(InstanceId id) {
        return repo.findById(id);
    }

    Instance[] list() {
        return repo.findAll();
    }

    Instance[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Instance[] listByStatus(InstanceStatus status) {
        return repo.findByStatus(status);
    }

    Instance[] listByAvailabilityZone(string zone) {
        return repo.findByAvailabilityZone(zone);
    }

    CommandResult create(InstanceDTO dto) {
        Instance i;
        i.id = dto.id;
        i.tenantId = dto.tenantId;
        i.name = dto.name;
        i.description = dto.description;
        i.flavorId = dto.flavorId;
        i.imageId = dto.imageId;
        i.availabilityZone = dto.availabilityZone;
        i.hostId = dto.hostId;
        i.keyPairId = dto.keyPairId;
        i.networkIds = dto.networkIds;
        i.securityGroupIds = dto.securityGroupIds;
        i.serverGroupId = dto.serverGroupId;
        i.userData = dto.userData;
        i.createdBy = dto.createdBy;
        if (!ResourceValidator.isValidInstance(i))
            return CommandResult(false, "", "Invalid instance data");
        repo.save(i);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(InstanceDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Instance not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.securityGroupIds.length > 0) existing.securityGroupIds = dto.securityGroupIds;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(InstanceId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Instance not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
