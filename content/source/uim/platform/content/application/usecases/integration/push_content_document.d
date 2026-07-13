module uim.platform.content.application.usecases.integration.push_content_document;

import uim.platform.content;

@safe:

class PushContentDocumentUseCase {
    private DocumentRepository documentRepo;
    private ContentStorageGateway gateway;

    this(DocumentRepository documentRepo, ContentStorageGateway gateway) {
        this.documentRepo = documentRepo;
        this.gateway = gateway;
    }

    CommandResult pushDocument(string documentId) {
        auto document = documentRepo.get_(documentId);
        if (document is null) {
            return CommandResult(false, "", "Document not found");
        }

        return gateway.pushDocument(*document);
    }
}
