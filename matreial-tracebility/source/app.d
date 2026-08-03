module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.material_traceability;

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
    writeln("  Material Traceability Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /ui");
    writeln("    CRUD   /api/v1/mt/<objectType>");
    writeln("    GET    /api/v1/mt/search/events?q=<query>");
    writeln("    GET    /api/v1/mt/lineage/by-material/:materialId");
    writeln("    GET    /api/v1/mt/compliance/by-lot/:lotId");
    writeln("    POST   /api/v1/mt/recall-simulations");
    writeln("    GET    /api/v1/mt/api-catalog");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
