module uim.platform.content.application.usecases.manage.manage_document_versions;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.content;

@safe:

class ManageDocumentVersionsUseCase {
    private DocumentVersionRepository versionRepo;
    private DocumentRepository documentRepo;

    this(DocumentVersionRepository versionRepo, DocumentRepository documentRepo) {
        this.versionRepo = versionRepo;
        this.documentRepo = documentRepo;
    }

    DocumentVersion[] listByDocumentId(string documentId) {
        return versionRepo.listByDocumentId(documentId);
    }

    const(DocumentVersion)* get_(string id) {
        return versionRepo.get_(id);
    }

    CommandResult create(DocumentVersionDTO dto) {
        if (documentRepo.get_(dto.documentId) is null) {
            return CommandResult(false, "", "Document not found");
        }

        DocumentVersion value;
        value.id = dto.id.length ? dto.id : createCode("VER");
        value.tenantId = dto.tenantId;
        value.documentId = dto.documentId;
        value.versionLabel = dto.versionLabel.length ? dto.versionLabel : "1.0";
        value.fileName = dto.fileName;
        value.mimeType = dto.mimeType;
        value.fileSize = dto.fileSize;
        value.checksum = dto.checksum;
        value.storageUri = dto.storageUri;
        value.versionNote = dto.versionNote;
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!ContentValidator.isValidVersion(value)) {
            return CommandResult(false, "", "Version documentId and versionLabel are required");
        }

        if (!versionRepo.create(value)) {
            return CommandResult(false, "", "Document version already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!versionRepo.remove(id)) {
            return CommandResult(false, "", "Document version not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        return prefix ~ "-" ~ to!string(Clock.currTime().toUnixTime());
    }
}
