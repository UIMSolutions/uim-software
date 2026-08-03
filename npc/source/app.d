module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.npc;

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
    writeln("  Planning Collaboration Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /ui");
    writeln("    CRUD   /api/v1/npc/<objectType>");
    writeln("    GET    /api/v1/npc/search/plans?q=<query>");
    writeln("    GET    /api/v1/npc/capacities/by-resource/:resourceId");
    writeln("    GET    /api/v1/npc/allocations/by-demand/:demandId");
    writeln("    POST   /api/v1/npc/simulations");
    writeln("    GET    /api/v1/npc/api-catalog");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
