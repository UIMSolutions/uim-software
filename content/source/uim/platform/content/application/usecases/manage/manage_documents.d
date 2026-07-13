module uim.platform.content.application.usecases.manage.manage_documents;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.content;

@safe:

class ManageDocumentsUseCase {
    private DocumentRepository documentRepo;
    private FolderRepository folderRepo;
    private ContentRepositoryRepository repositoryRepo;
    private DocumentVersionRepository versionRepo;

    this(
        DocumentRepository documentRepo,
        FolderRepository folderRepo,
        ContentRepositoryRepository repositoryRepo,
        DocumentVersionRepository versionRepo
    ) {
        this.documentRepo = documentRepo;
        this.folderRepo = folderRepo;
        this.repositoryRepo = repositoryRepo;
        this.versionRepo = versionRepo;
    }

    Document[] list() {
        return documentRepo.list();
    }

    const(Document)* get_(string id) {
        return documentRepo.get_(id);
    }

    CommandResult create(DocumentDTO dto) {
        if (repositoryRepo.get_(dto.repositoryId) is null) {
            return CommandResult(false, "", "Repository not found");
        }
        if (dto.folderId.length && folderRepo.get_(dto.folderId) is null) {
            return CommandResult(false, "", "Folder not found");
        }

        Document value;
        value.id = dto.id.length ? dto.id : createCode("DOC");
        value.tenantId = dto.tenantId;
        value.repositoryId = dto.repositoryId;
        value.folderId = dto.folderId;
        value.title = dto.title;
        value.documentNumber = dto.documentNumber;
        value.objectType = dto.objectType;
        value.mimeType = dto.mimeType;
        value.fileName = dto.fileName;
        value.fileSize = dto.fileSize;
        value.checksum = dto.checksum;
        value.storageUri = dto.storageUri;
        value.status = dto.status.length ? dto.status : "draft";
        value.classification = dto.classification;
        value.tags = dto.tags;
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!ContentValidator.isValidDocument(value)) {
            return CommandResult(false, "", "Document repositoryId and title are required");
        }

        if (!documentRepo.create(value)) {
            return CommandResult(false, "", "Document already exists");
        }

        auto firstVersion = DocumentVersion(
            createCode("VER"),
            dto.tenantId,
            value.id,
            "1.0",
            value.fileName,
            value.mimeType,
            value.fileSize,
            value.checksum,
            value.storageUri,
            "Initial version",
            dto.createdBy,
            Clock.currTime().toISOExtString()
        );
        versionRepo.create(firstVersion);

        return CommandResult(true, value.id, "");
    }

    CommandResult update(DocumentDTO dto) {
        auto current = documentRepo.get_(dto.id);
        if (current is null) {
            return CommandResult(false, "", "Document not found");
        }

        if (dto.folderId.length && folderRepo.get_(dto.folderId) is null) {
            return CommandResult(false, "", "Folder not found");
        }

        Document value = *current;
        if (dto.repositoryId.length) value.repositoryId = dto.repositoryId;
        if (dto.folderId.length) value.folderId = dto.folderId;
        if (dto.title.length) value.title = dto.title;
        if (dto.documentNumber.length) value.documentNumber = dto.documentNumber;
        if (dto.objectType.length) value.objectType = dto.objectType;
        if (dto.mimeType.length) value.mimeType = dto.mimeType;
        if (dto.fileName.length) value.fileName = dto.fileName;
        if (dto.fileSize.length) value.fileSize = dto.fileSize;
        if (dto.checksum.length) value.checksum = dto.checksum;
        if (dto.storageUri.length) value.storageUri = dto.storageUri;
        if (dto.status.length) value.status = dto.status;
        if (dto.classification.length) value.classification = dto.classification;
        if (dto.tags.length) value.tags = dto.tags;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!documentRepo.update(value)) {
            return CommandResult(false, "", "Document not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!documentRepo.remove(id)) {
            return CommandResult(false, "", "Document not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        return prefix ~ "-" ~ to!string(Clock.currTime().toUnixTime());
    }
}
