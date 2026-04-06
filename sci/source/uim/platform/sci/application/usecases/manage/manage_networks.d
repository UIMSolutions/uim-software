/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.application.usecases.manage.manage_networks;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class ManageNetworksUseCase : UIMUseCase {
    private NetworkRepository repo;

    this(NetworkRepository repo) {
        this.repo = repo;
    }

    Network* get_(NetworkId id) {
        return repo.findById(id);
    }

    Network[] list() {
        return repo.findAll();
    }

    Network[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Network[] listByType(NetworkType networkType) {
        return repo.findByType(networkType);
    }

    Network[] listByStatus(NetworkStatus status) {
        return repo.findByStatus(status);
    }

    CommandResult create(NetworkDTO dto) {
        Network n;
        n.id = dto.id;
        n.tenantId = dto.tenantId;
        n.name = dto.name;
        n.description = dto.description;
        n.cidr = dto.cidr;
        n.gateway = dto.gateway;
        n.dnsNameservers = dto.dnsNameservers;
        n.isShared = dto.isShared;
        n.isExternal = dto.isExternal;
        n.availabilityZone = dto.availabilityZone;
        n.createdBy = dto.createdBy;
        if (!ResourceValidator.isValidNetwork(n))
            return CommandResult(false, "", "Invalid network data");
        repo.save(n);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(NetworkDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Network not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.gateway.length > 0) existing.gateway = dto.gateway;
        if (dto.dnsNameservers.length > 0) existing.dnsNameservers = dto.dnsNameservers;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(NetworkId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Network not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
