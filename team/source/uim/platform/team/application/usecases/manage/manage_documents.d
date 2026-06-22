module uim.platform.team.application.usecases.manage.manage_documents;

import std.conv : to;
import uim.platform.team;

@safe:

class ManageDocumentsUseCase : UIMUseCase {
    private DocumentRepository repo;
    private PartRepository partRepo;

    this(DocumentRepository repo, PartRepository partRepo) {
        this.repo = repo;
        this.partRepo = partRepo;
    }

    Document[] listByTenant(TenantId tenantId) {
        if (tenantId.length == 0) return repo.findAll();
        return repo.findByTenant(tenantId);
    }

    Document* get_(DocumentId id) { return repo.findById(id); }

    CommandResult create(DocumentDTO dto) {
        if (dto.title.length == 0 || dto.docNumber.length == 0)
            return CommandResult(false, "", "Document title and number are required");

        if (dto.relatedPartId.length > 0 && partRepo.findById(dto.relatedPartId) is null)
            return CommandResult(false, "", "Related part not found");

        Document document;
        document.id = dto.id.length > 0 ? dto.id : "doc-" ~ to!string(repo.findAll().length + 1);
        document.tenantId = dto.tenantId;
        document.title = dto.title;
        document.docNumber = dto.docNumber;
        document.revision = dto.revision;
        document.docType = ChangePolicy.parseDocumentType(dto.docType);
        document.fileName = dto.fileName;
        document.fileUri = dto.fileUri;
        document.relatedPartId = dto.relatedPartId;
        document.relatedChangeId = dto.relatedChangeId;
        document.owner = dto.owner;
        document.createdBy = dto.createdBy;
        document.modifiedBy = dto.modifiedBy;
        document.createdAt = dto.createdAt;
        document.modifiedAt = dto.modifiedAt;

        repo.save(document);
        return CommandResult(true, document.id, "");
    }

    CommandResult update(DocumentDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Document not found");

        if (dto.relatedPartId.length > 0 && partRepo.findById(dto.relatedPartId) is null)
            return CommandResult(false, "", "Related part not found");

        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.docNumber.length > 0) existing.docNumber = dto.docNumber;
        if (dto.revision.length > 0) existing.revision = dto.revision;
        if (dto.docType.length > 0)
            existing.docType = ChangePolicy.parseDocumentType(dto.docType, existing.docType);
        if (dto.fileName.length > 0) existing.fileName = dto.fileName;
        if (dto.fileUri.length > 0) existing.fileUri = dto.fileUri;
        if (dto.relatedPartId.length > 0) existing.relatedPartId = dto.relatedPartId;
        if (dto.relatedChangeId.length > 0) existing.relatedChangeId = dto.relatedChangeId;
        if (dto.owner.length > 0) existing.owner = dto.owner;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(DocumentId id) {
        if (repo.findById(id) is null)
            return CommandResult(false, "", "Document not found");

        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
