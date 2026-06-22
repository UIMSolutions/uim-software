module uim.platform.mes.application.usecases.manage.documents;

import uim.platform.mes;

@safe:

class ManageDocumentsUseCase : UIMUseCase {
    private DocumentRepository repo;
    this(DocumentRepository repo) { this.repo = repo; }
    Document[] list() { return repo.findAll(); }
    Document* get_(DocumentId id) { return repo.findById(id); }
    CommandResult create(DocumentDTO dto) {
        Document value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.orderId = dto.orderId;
        value.name = dto.name;
        value.description = dto.description;
        value.documentType = dto.documentType;
        value.status = dto.status.length ? dto.status : value.status;
        value.documentNumber = dto.documentNumber;
        value.fileName = dto.fileName;
        value.mimeType = dto.mimeType;
        value.language = dto.language;
        value.author = dto.author;
        value.approvedBy = dto.approvedBy;
        value.createdBy = dto.createdBy;
        if (!MesValidator.isValidDocument(value)) {
            return CommandResult(false, "", "Invalid document data");
        }
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }
    CommandResult update(DocumentDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Document not found");
        }
        if (dto.name.length) existing.name = dto.name;
        if (dto.description.length) existing.description = dto.description;
        if (dto.documentType.length) existing.documentType = dto.documentType;
        if (dto.status.length) existing.status = dto.status;
        if (dto.documentNumber.length) existing.documentNumber = dto.documentNumber;
        if (dto.fileName.length) existing.fileName = dto.fileName;
        if (dto.mimeType.length) existing.mimeType = dto.mimeType;
        if (dto.language.length) existing.language = dto.language;
        if (dto.author.length) existing.author = dto.author;
        if (dto.approvedBy.length) existing.approvedBy = dto.approvedBy;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }
    CommandResult remove(DocumentId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Document not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
