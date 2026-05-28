/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.application.usecases.manage.manage_threat_indicators;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class ManageThreatIndicatorsUseCase : UIMUseCase {
    private ThreatIndicatorRepository repo;

    this(ThreatIndicatorRepository repo) {
        this.repo = repo;
    }

    ThreatIndicator* get_(ThreatIndicatorId id) {
        return repo.findById(id);
    }

    ThreatIndicator[] list() {
        return repo.findAll();
    }

    ThreatIndicator[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    ThreatIndicator[] listByType(ThreatIndicatorType indicatorType) {
        return repo.findByType(indicatorType);
    }

    ThreatIndicator[] listByConfidence(ThreatIndicatorConfidence confidence) {
        return repo.findByConfidence(confidence);
    }

    CommandResult create(ThreatIndicatorDTO dto) {
        ThreatIndicator t;
        t.id = dto.id;
        t.tenantId = dto.tenantId;
        t.name = dto.name;
        t.description = dto.description;
        t.value = dto.value;
        t.threatActor = dto.threatActor;
        t.malwareFamily = dto.malwareFamily;
        t.campaign = dto.campaign;
        t.tlpLevel = dto.tlpLevel;
        t.source = dto.source;
        t.tags = dto.tags;
        t.expiresAt = dto.expiresAt;
        t.firstSeenAt = dto.firstSeenAt;
        t.lastSeenAt = dto.lastSeenAt;
        t.createdBy = dto.createdBy;
        if (!SiemValidator.isValidThreatIndicator(t))
            return CommandResult(false, "", "Invalid threat indicator data");
        repo.save(t);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ThreatIndicatorDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Threat indicator not found");
        if (dto.value.length > 0) existing.value = dto.value;
        if (dto.threatActor.length > 0) existing.threatActor = dto.threatActor;
        if (dto.malwareFamily.length > 0) existing.malwareFamily = dto.malwareFamily;
        if (dto.lastSeenAt.length > 0) existing.lastSeenAt = dto.lastSeenAt;
        if (dto.expiresAt.length > 0) existing.expiresAt = dto.expiresAt;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ThreatIndicatorId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Threat indicator not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
