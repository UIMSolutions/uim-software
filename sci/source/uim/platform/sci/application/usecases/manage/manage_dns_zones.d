/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.application.usecases.manage.manage_dns_zones;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class ManageDnsZonesUseCase : UIMUseCase {
    private DnsZoneRepository repo;

    this(DnsZoneRepository repo) {
        this.repo = repo;
    }

    DnsZone* get_(DnsZoneId id) {
        return repo.findById(id);
    }

    DnsZone[] list() {
        return repo.findAll();
    }

    DnsZone[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    DnsZone[] listByStatus(DnsZoneStatus status) {
        return repo.findByStatus(status);
    }

    DnsZone[] listByZoneType(DnsZoneType zoneType) {
        return repo.findByZoneType(zoneType);
    }

    CommandResult create(DnsZoneDTO dto) {
        DnsZone dz;
        dz.id = dto.id;
        dz.tenantId = dto.tenantId;
        dz.name = dto.name;
        dz.description = dto.description;
        dz.email = dto.email;
        dz.ttl = dto.ttl;
        dz.serial = dto.serial;
        dz.recordName = dto.recordName;
        dz.recordData = dto.recordData;
        dz.createdBy = dto.createdBy;
        if (!ResourceValidator.isValidDnsZone(dz))
            return CommandResult(false, "", "Invalid DNS zone data");
        repo.save(dz);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(DnsZoneDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "DNS zone not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.ttl.length > 0) existing.ttl = dto.ttl;
        if (dto.recordName.length > 0) existing.recordName = dto.recordName;
        if (dto.recordData.length > 0) existing.recordData = dto.recordData;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(DnsZoneId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "DNS zone not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
