module uim.platform.content.infrastructure.integrations.storage.content_storage_stub;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.content;

@safe:

class ContentStorageStubGateway : ContentStorageGateway {
    override CommandResult pushDocument(Document document) {
        if (!document.id.length) {
            return CommandResult(false, "", "Document id is required");
        }

        auto ticket = "CS-" ~ to!string(Clock.currTime().toUnixTime());
        return CommandResult(true, ticket, "Document push accepted");
    }
}
