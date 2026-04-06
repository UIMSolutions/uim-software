/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.application.usecases.manage.manage_load_balancers;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class ManageLoadBalancersUseCase : UIMUseCase {
    private LoadBalancerRepository repo;

    this(LoadBalancerRepository repo) {
        this.repo = repo;
    }

    LoadBalancer* get_(LoadBalancerId id) {
        return repo.findById(id);
    }

    LoadBalancer[] list() {
        return repo.findAll();
    }

    LoadBalancer[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    LoadBalancer[] listByStatus(LoadBalancerStatus status) {
        return repo.findByStatus(status);
    }

    LoadBalancer[] listByAlgorithm(LoadBalancerAlgorithm algorithm) {
        return repo.findByAlgorithm(algorithm);
    }

    CommandResult create(LoadBalancerDTO dto) {
        LoadBalancer lb;
        lb.id = dto.id;
        lb.tenantId = dto.tenantId;
        lb.name = dto.name;
        lb.description = dto.description;
        lb.vipAddress = dto.vipAddress;
        lb.vipSubnetId = dto.vipSubnetId;
        lb.protocol = dto.protocol;
        lb.protocolPort = dto.protocolPort;
        lb.healthMonitorUrl = dto.healthMonitorUrl;
        lb.members = dto.members;
        lb.createdBy = dto.createdBy;
        if (!ResourceValidator.isValidLoadBalancer(lb))
            return CommandResult(false, "", "Invalid load balancer data");
        repo.save(lb);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(LoadBalancerDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Load balancer not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.healthMonitorUrl.length > 0) existing.healthMonitorUrl = dto.healthMonitorUrl;
        if (dto.members.length > 0) existing.members = dto.members;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(LoadBalancerId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Load balancer not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
