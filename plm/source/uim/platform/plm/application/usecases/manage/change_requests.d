module uim.platform.plm.application.usecases.manage.change_requests;

import uim.platform.plm;

@safe:

class ManageChangeRequestsUseCase : UIMUseCase {
    private ChangeRequestRepository repo;
    this(ChangeRequestRepository repo) { this.repo = repo; }
    ChangeRequest[] list() { return repo.findAll(); }
    ChangeRequest* get_(ChangeRequestId id) { return repo.findById(id); }
    CommandResult create(ChangeRequestDTO dto) {
        ChangeRequest value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.productId = dto.productId;
        value.title = dto.title;
        value.description = dto.description;
        value.priority = dto.priority;
        value.status = dto.status.length ? dto.status : value.status;
        value.reason = dto.reason;
        value.impact = dto.impact;
        value.requestedBy = dto.requestedBy;
        value.assignedTo = dto.assignedTo;
        value.approvedBy = dto.approvedBy;
        value.affectedDocumentIds = dto.affectedDocumentIds;
        value.affectedBomIds = dto.affectedBomIds;
        value.createdBy = dto.createdBy;
        if (!PlmValidator.isValidChangeRequest(value)) {
            return CommandResult(false, "", "Invalid change request data");
        }
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }
    CommandResult update(ChangeRequestDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Change request not found");
        }
        if (dto.title.length) existing.title = dto.title;
        if (dto.description.length) existing.description = dto.description;
        if (dto.priority.length) existing.priority = dto.priority;
        if (dto.status.length) existing.status = dto.status;
        if (dto.reason.length) existing.reason = dto.reason;
        if (dto.impact.length) existing.impact = dto.impact;
        if (dto.requestedBy.length) existing.requestedBy = dto.requestedBy;
        if (dto.assignedTo.length) existing.assignedTo = dto.assignedTo;
        if (dto.approvedBy.length) existing.approvedBy = dto.approvedBy;
        if (dto.affectedDocumentIds.length) existing.affectedDocumentIds = dto.affectedDocumentIds;
        if (dto.affectedBomIds.length) existing.affectedBomIds = dto.affectedBomIds;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }
    CommandResult remove(ChangeRequestId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Change request not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
