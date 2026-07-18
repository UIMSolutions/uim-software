/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_slas;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageSLAsUseCase : UIMUseCase {
    private SLARepository repo;

    this(SLARepository repo) { this.repo = repo; }

    ServiceLevelAgreement* get_(ServiceLevelAgreementId id) { return repo.findById(id); }
    ServiceLevelAgreement[] list() { return repo.findAll(); }
    ServiceLevelAgreement[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    ServiceLevelAgreement[] listByStatus(SLAStatus slaStatus) { return repo.findByStatus(slaStatus); }
    ServiceLevelAgreement[] listByService(ITServiceId serviceId) { return repo.findByService(serviceId); }
    ServiceLevelAgreement[] listByCustomer(string customerId) { return repo.findByCustomer(customerId); }

    CommandResult create(ServiceLevelAgreementDTO dto) {
        ServiceLevelAgreement sla;
        sla.id = dto.id;
        sla.tenantId = dto.tenantId;
        sla.name = dto.name;
        sla.description = dto.description;
        sla.serviceId = dto.serviceId;
        sla.customerId = dto.customerId;
        sla.startDate = dto.startDate;
        sla.endDate = dto.endDate;
        sla.availabilityTarget = dto.availabilityTarget;
        sla.mttrTarget = dto.mttrTarget;
        sla.responseTimeTarget = dto.responseTimeTarget;
        sla.resolutionTimeTarget = dto.resolutionTimeTarget;
        sla.accountManager = dto.accountManager;
        sla.createdBy = dto.createdBy;
        if (!ITILValidator.isValidSLA(sla))
            return CommandResult(false, "", "Invalid SLA data");
        repo.save(sla);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ServiceLevelAgreementDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "SLA not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.availabilityTarget.length > 0) existing.availabilityTarget = dto.availabilityTarget;
        if (dto.endDate.length > 0) existing.endDate = dto.endDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ServiceLevelAgreementId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "SLA not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
