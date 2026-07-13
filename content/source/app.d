module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.content;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    container.healthController.registerRoutes(router);
    container.repositoryController.registerRoutes(router);
    container.folderController.registerRoutes(router);
    container.documentController.registerRoutes(router);
    container.versionController.registerRoutes(router);
    container.integrationController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Content Server Service (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/content/repositories");
    writeln("    POST   /api/v1/content/repositories");
    writeln("    GET    /api/v1/content/folders");
    writeln("    POST   /api/v1/content/folders");
    writeln("    GET    /api/v1/content/documents");
    writeln("    POST   /api/v1/content/documents");
    writeln("    GET    /api/v1/content/documents/:id");
    writeln("    PUT    /api/v1/content/documents/:id");
    writeln("    DELETE /api/v1/content/documents/:id");
    writeln("    GET    /api/v1/content/documents/:id/versions");
    writeln("    POST   /api/v1/content/documents/:id/versions");
    writeln("    POST   /api/v1/content/integrations/push-document/:documentId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
