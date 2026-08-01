module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.ecm;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    container.healthController.registerRoutes(router);
    container.apiController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Enterprise Content Management Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /ui");
    writeln("    GET    /api/v1/ecm/:objectType");
    writeln("    POST   /api/v1/ecm/:objectType");
    writeln("    GET    /api/v1/ecm/:objectType/:id");
    writeln("    PUT    /api/v1/ecm/:objectType/:id");
    writeln("    DELETE /api/v1/ecm/:objectType/:id");
    writeln("    GET    /api/v1/ecm/search/documents");
    writeln("    GET    /api/v1/ecm/document-versions/by-document/:documentId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
