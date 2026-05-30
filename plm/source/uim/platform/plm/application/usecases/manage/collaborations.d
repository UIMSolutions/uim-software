module uim.platform.plm.application.usecases.manage.collaborations;

import uim.platform.plm;

@safe:

class ManageCollaborationsUseCase : UIMUseCase {
    private CollaborationRepository repo;
    this(CollaborationRepository repo) { this.repo = repo; }
    Collaboration[] list() { return repo.findAll(); }
    Collaboration* get_(CollaborationId id) { return repo.findById(id); }
    CommandResult create(CollaborationDTO dto) {
        Collaboration value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.productId = dto.productId;
        value.title = dto.title;
        value.description = dto.description;
        value.collaborationType = dto.collaborationType;
        value.status = dto.status.length ? dto.status : value.status;
        value.assignedTo = dto.assignedTo;
        value.participants = dto.participants;
        value.dueDate = dto.dueDate;
        value.resolvedDate = dto.resolvedDate;
        value.resolution = dto.resolution;
        value.relatedDocumentId = dto.relatedDocumentId;
        value.relatedChangeRequestId = dto.relatedChangeRequestId;
        value.createdBy = dto.createdBy;
        if (!PlmValidator.isValidCollaboration(value)) {
            return CommandResult(false, "", "Invalid collaboration data");
        }
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }
    CommandResult update(CollaborationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Collaboration not found");
        }
        if (dto.title.length) existing.title = dto.title;
        if (dto.description.length) existing.description = dto.description;
        if (dto.collaborationType.length) existing.collaborationType = dto.collaborationType;
        if (dto.status.length) existing.status = dto.status;
        if (dto.assignedTo.length) existing.assignedTo = dto.assignedTo;
        if (dto.participants.length) existing.participants = dto.participants;
        if (dto.dueDate.length) existing.dueDate = dto.dueDate;
        if (dto.resolvedDate.length) existing.resolvedDate = dto.resolvedDate;
        if (dto.resolution.length) existing.resolution = dto.resolution;
        if (dto.relatedDocumentId.length) existing.relatedDocumentId = dto.relatedDocumentId;
        if (dto.relatedChangeRequestId.length) existing.relatedChangeRequestId = dto.relatedChangeRequestId;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }
    CommandResult remove(CollaborationId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Collaboration not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
