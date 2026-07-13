module uim.platform.content.domain.integration.content_storage_gateway;

import uim.platform.content.application.dto : CommandResult;
import uim.platform.content.domain.entities.document : Document;

@safe:

interface ContentStorageGateway {
    CommandResult pushDocument(Document document);
}
