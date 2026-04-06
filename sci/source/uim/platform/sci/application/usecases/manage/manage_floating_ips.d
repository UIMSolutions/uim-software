/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.application.usecases.manage.manage_floating_ips;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class ManageFloatingIpsUseCase : UIMUseCase {
    private FloatingIpRepository repo;

    this(FloatingIpRepository repo) {
        this.repo = repo;
    }

    FloatingIp* get_(FloatingIpId id) {
        return repo.findById(id);
    }

    FloatingIp[] list() {
        return repo.findAll();
    }

    FloatingIp[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    FloatingIp[] listByStatus(FloatingIpStatus status) {
        return repo.findByStatus(status);
    }

    FloatingIp[] listByInstance(InstanceId instanceId) {
        return repo.findByInstance(instanceId);
    }

    CommandResult create(FloatingIpDTO dto) {
        FloatingIp fip;
        fip.id = dto.id;
        fip.tenantId = dto.tenantId;
        fip.name = dto.name;
        fip.description = dto.description;
        fip.floatingIpAddress = dto.floatingIpAddress;
        fip.fixedIpAddress = dto.fixedIpAddress;
        fip.networkId = dto.networkId;
        fip.instanceId = dto.instanceId;
        fip.routerId = dto.routerId;
        fip.createdBy = dto.createdBy;
        if (!ResourceValidator.isValidFloatingIp(fip))
            return CommandResult(false, "", "Invalid floating IP data");
        repo.save(fip);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(FloatingIpDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Floating IP not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.instanceId.length > 0) existing.instanceId = dto.instanceId;
        if (dto.fixedIpAddress.length > 0) existing.fixedIpAddress = dto.fixedIpAddress;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(FloatingIpId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Floating IP not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
