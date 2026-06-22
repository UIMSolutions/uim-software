module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.team;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();
    container.healthController.registerRoutes(router);
    container.partsController.registerRoutes(router);
    container.bomController.registerRoutes(router);
    container.documentsController.registerRoutes(router);
    container.changesController.registerRoutes(router);
    container.plmAnalysisController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Product Lifecycle Management Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/team/parts");
    writeln("    POST   /api/v1/team/parts");
    writeln("    GET    /api/v1/team/parts/*");
    writeln("    PUT    /api/v1/team/parts/*");
    writeln("    DELETE /api/v1/team/parts/*");
    writeln("    GET    /api/v1/team/boms");
    writeln("    POST   /api/v1/team/boms");
    writeln("    GET    /api/v1/team/boms/*");
    writeln("    PUT    /api/v1/team/boms/*");
    writeln("    DELETE /api/v1/team/boms/*");
    writeln("    GET    /api/v1/team/documents");
    writeln("    POST   /api/v1/team/documents");
    writeln("    GET    /api/v1/team/documents/*");
    writeln("    PUT    /api/v1/team/documents/*");
    writeln("    DELETE /api/v1/team/documents/*");
    writeln("    GET    /api/v1/team/changes");
    writeln("    POST   /api/v1/team/changes");
    writeln("    GET    /api/v1/team/changes/*");
    writeln("    PUT    /api/v1/team/changes/*");
    writeln("    DELETE /api/v1/team/changes/*");
    writeln("    GET    /api/v1/team/plm/summary");
    writeln("    GET    /api/v1/team/plm/change-impact");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
