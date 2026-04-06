/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.application.usecases.manage.manage_security_groups;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class ManageSecurityGroupsUseCase : UIMUseCase {
    private SecurityGroupRepository repo;

    this(SecurityGroupRepository repo) {
        this.repo = repo;
    }

    SecurityGroup* get_(SecurityGroupId id) {
        return repo.findById(id);
    }

    SecurityGroup[] list() {
        return repo.findAll();
    }

    SecurityGroup[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    SecurityGroup[] listByDirection(SecurityGroupDirection direction) {
        return repo.findByDirection(direction);
    }

    SecurityGroup[] listByProtocol(SecurityGroupProtocol protocol) {
        return repo.findByProtocol(protocol);
    }

    CommandResult create(SecurityGroupDTO dto) {
        SecurityGroup sg;
        sg.id = dto.id;
        sg.tenantId = dto.tenantId;
        sg.name = dto.name;
        sg.description = dto.description;
        sg.portRangeMin = dto.portRangeMin;
        sg.portRangeMax = dto.portRangeMax;
        sg.remoteIpPrefix = dto.remoteIpPrefix;
        sg.remoteGroupId = dto.remoteGroupId;
        sg.etherType = dto.etherType;
        sg.createdBy = dto.createdBy;
        if (!ResourceValidator.isValidSecurityGroup(sg))
            return CommandResult(false, "", "Invalid security group data");
        repo.save(sg);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(SecurityGroupDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Security group not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.portRangeMin.length > 0) existing.portRangeMin = dto.portRangeMin;
        if (dto.portRangeMax.length > 0) existing.portRangeMax = dto.portRangeMax;
        if (dto.remoteIpPrefix.length > 0) existing.remoteIpPrefix = dto.remoteIpPrefix;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(SecurityGroupId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Security group not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
