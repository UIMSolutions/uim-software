module uim.platform.content.domain.services.content_validator;

import uim.platform.content.domain.entities.content_repository : ContentRepository;
import uim.platform.content.domain.entities.folder : Folder;
import uim.platform.content.domain.entities.document : Document;
import uim.platform.content.domain.entities.document_version : DocumentVersion;

@safe:

struct ContentValidator {
    static bool isValidRepository(ContentRepository value) {
        return value.name.length > 0 && value.storageType.length > 0;
    }

    static bool isValidFolder(Folder value) {
        return value.repositoryId.length > 0 && value.name.length > 0;
    }

    static bool isValidDocument(Document value) {
        return value.repositoryId.length > 0 && value.title.length > 0;
    }

    static bool isValidVersion(DocumentVersion value) {
        return value.documentId.length > 0 && value.versionLabel.length > 0;
    }
}
