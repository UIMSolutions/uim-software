/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_service_requests;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageServiceRequestsUseCase : UIMUseCase {
    private ServiceRequestRepository repo;

    this(ServiceRequestRepository repo) { this.repo = repo; }

    ServiceRequest* get_(ServiceRequestId id) { return repo.findById(id); }
    ServiceRequest[] list() { return repo.findAll(); }
    ServiceRequest[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    ServiceRequest[] listByStatus(RecordStatus status) { return repo.findByStatus(status); }
    ServiceRequest[] listByPriority(Priority priority) { return repo.findByPriority(priority); }
    ServiceRequest[] listByService(ITServiceId serviceId) { return repo.findByService(serviceId); }

    CommandResult create(ServiceRequestDTO dto) {
        ServiceRequest r;
        r.id = dto.id;
        r.tenantId = dto.tenantId;
        r.title = dto.title;
        r.description = dto.description;
        r.requesterId = dto.requesterId;
        r.requestDate = dto.requestDate;
        r.requiredByDate = dto.requiredByDate;
        r.assignedTo = dto.assignedTo;
        r.serviceId = dto.serviceId;
        r.category = dto.category;
        r.createdBy = dto.createdBy;
        if (!ITILValidator.isValidServiceRequest(r))
            return CommandResult(false, "", "Invalid service request data");
        repo.save(r);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ServiceRequestDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Service request not found");
        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.assignedTo.length > 0) existing.assignedTo = dto.assignedTo;
        if (dto.resolutionNotes.length > 0) existing.resolutionNotes = dto.resolutionNotes;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ServiceRequestId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Service request not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
