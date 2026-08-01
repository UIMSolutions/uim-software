module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.pp;

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
    writeln("  Production Planning Service (S/4HANA PP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /health");
    writeln("    GET    /ui");
    writeln("    CRUD   /api/v1/pp/materials");
    writeln("    CRUD   /api/v1/pp/work-centers");
    writeln("    CRUD   /api/v1/pp/bills-of-material");
    writeln("    CRUD   /api/v1/pp/routings");
    writeln("    CRUD   /api/v1/pp/planned-orders");
    writeln("    CRUD   /api/v1/pp/production-orders");
    writeln("    POST   /api/v1/pp/mrp-runs/execute");
    writeln("    GET    /api/v1/pp/planned-orders/by-material/:materialId");
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
