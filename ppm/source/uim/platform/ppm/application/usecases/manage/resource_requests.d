module uim.platform.ppm.application.usecases.manage.resource_requests;

import uim.platform.ppm;

@safe:

class ManageResourceRequestsUseCase : UIMUseCase {
    private ResourceRequestRepository repo;

    this(ResourceRequestRepository repo) { this.repo = repo; }

    ResourceRequest[] list() { return repo.findAll(); }
    ResourceRequest* get_(ResourceRequestId id) { return repo.findById(id); }

    CommandResult create(ResourceRequestDTO dto) {
        ResourceRequest value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.projectId = dto.projectId;
        value.role = dto.role;
        value.quantity = dto.quantity;
        value.allocationPercent = dto.allocationPercent;
        value.startDate = dto.startDate;
        value.endDate = dto.endDate;
        value.status = dto.status.length ? dto.status : value.status;
        value.requestedBy = dto.requestedBy;
        value.createdBy = dto.createdBy;
        if (!PpmValidator.isValidResourceRequest(value)) return CommandResult(false, "", "Invalid resource request data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ResourceRequestDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Resource request not found");
        if (dto.projectId.length) existing.projectId = dto.projectId;
        if (dto.role.length) existing.role = dto.role;
        if (dto.quantity.length) existing.quantity = dto.quantity;
        if (dto.allocationPercent.length) existing.allocationPercent = dto.allocationPercent;
        if (dto.startDate.length) existing.startDate = dto.startDate;
        if (dto.endDate.length) existing.endDate = dto.endDate;
        if (dto.status.length) existing.status = dto.status;
        if (dto.requestedBy.length) existing.requestedBy = dto.requestedBy;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ResourceRequestId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Resource request not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
