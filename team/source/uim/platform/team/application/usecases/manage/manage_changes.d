module uim.platform.team.application.usecases.manage.manage_changes;

import std.conv : to;
import uim.platform.team;

@safe:

class ManageChangesUseCase : UIMUseCase {
    private ChangeRequestRepository repo;
    private PartRepository partRepo;
    private DocumentRepository documentRepo;

    this(ChangeRequestRepository repo, PartRepository partRepo, DocumentRepository documentRepo) {
        this.repo = repo;
        this.partRepo = partRepo;
        this.documentRepo = documentRepo;
    }

    ChangeRequest[] listByTenant(TenantId tenantId) {
        if (tenantId.length == 0) return repo.findAll();
        return repo.findByTenant(tenantId);
    }

    ChangeRequest* get_(ChangeId id) { return repo.findById(id); }

    CommandResult create(ChangeRequestDTO dto) {
        if (dto.changeNumber.length == 0 || dto.title.length == 0)
            return CommandResult(false, "", "Change number and title are required");

        foreach (partId; dto.affectedPartIds)
            if (partId.length > 0 && partRepo.findById(partId) is null)
                return CommandResult(false, "", "Affected part not found: " ~ partId);

        foreach (documentId; dto.affectedDocumentIds)
            if (documentId.length > 0 && documentRepo.findById(documentId) is null)
                return CommandResult(false, "", "Affected document not found: " ~ documentId);

        ChangeRequest changeRequest;
        changeRequest.id = dto.id.length > 0 ? dto.id : "change-" ~ to!string(repo.findAll().length + 1);
        changeRequest.tenantId = dto.tenantId;
        changeRequest.changeNumber = dto.changeNumber;
        changeRequest.title = dto.title;
        changeRequest.description = dto.description;
        changeRequest.state = ChangePolicy.parseChangeState(dto.state);
        changeRequest.severity = ChangePolicy.parseSeverity(dto.severity);
        changeRequest.affectedPartIds = dto.affectedPartIds;
        changeRequest.affectedDocumentIds = dto.affectedDocumentIds;
        changeRequest.requestedBy = dto.requestedBy;
        changeRequest.approver = dto.approver;
        changeRequest.targetImplementationDate = dto.targetImplementationDate;
        changeRequest.createdBy = dto.createdBy;
        changeRequest.modifiedBy = dto.modifiedBy;
        changeRequest.createdAt = dto.createdAt;
        changeRequest.modifiedAt = dto.modifiedAt;

        repo.save(changeRequest);
        return CommandResult(true, changeRequest.id, "");
    }

    CommandResult update(ChangeRequestDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Change request not found");

        if (dto.state.length > 0) {
            auto nextState = ChangePolicy.parseChangeState(dto.state, existing.state);
            if (!ChangePolicy.canTransition(existing.state, nextState))
                return CommandResult(false, "", "Invalid state transition");
            existing.state = nextState;
        }

        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.severity.length > 0)
            existing.severity = ChangePolicy.parseSeverity(dto.severity, existing.severity);
        if (dto.affectedPartIds.length > 0) existing.affectedPartIds = dto.affectedPartIds;
        if (dto.affectedDocumentIds.length > 0) existing.affectedDocumentIds = dto.affectedDocumentIds;
        if (dto.requestedBy.length > 0) existing.requestedBy = dto.requestedBy;
        if (dto.approver.length > 0) existing.approver = dto.approver;
        if (dto.targetImplementationDate.length > 0)
            existing.targetImplementationDate = dto.targetImplementationDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ChangeId id) {
        if (repo.findById(id) is null)
            return CommandResult(false, "", "Change request not found");

        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
