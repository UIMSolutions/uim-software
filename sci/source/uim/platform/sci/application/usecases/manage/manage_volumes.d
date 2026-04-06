/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.application.usecases.manage.manage_volumes;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class ManageVolumesUseCase : UIMUseCase {
    private VolumeRepository repo;

    this(VolumeRepository repo) {
        this.repo = repo;
    }

    Volume* get_(VolumeId id) {
        return repo.findById(id);
    }

    Volume[] list() {
        return repo.findAll();
    }

    Volume[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Volume[] listByStatus(VolumeStatus status) {
        return repo.findByStatus(status);
    }

    Volume[] listByInstance(InstanceId instanceId) {
        return repo.findByInstance(instanceId);
    }

    CommandResult create(VolumeDTO dto) {
        Volume v;
        v.id = dto.id;
        v.tenantId = dto.tenantId;
        v.name = dto.name;
        v.description = dto.description;
        v.size = dto.size;
        v.instanceId = dto.instanceId;
        v.availabilityZone = dto.availabilityZone;
        v.snapshotId = dto.snapshotId;
        v.sourceVolumeId = dto.sourceVolumeId;
        v.encrypted = dto.encrypted;
        v.createdBy = dto.createdBy;
        if (!ResourceValidator.isValidVolume(v))
            return CommandResult(false, "", "Invalid volume data");
        repo.save(v);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(VolumeDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Volume not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.size.length > 0) existing.size = dto.size;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(VolumeId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Volume not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
