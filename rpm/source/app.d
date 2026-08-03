module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.rpm;

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
    writeln("  Returnable Packaging Management Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /ui");
    writeln("    CRUD   /api/v1/rpm/<objectType>");
    writeln("    POST   /api/v1/rpm/operations");
    writeln("    GET    /api/v1/rpm/trace/:assetId");
    writeln("    GET    /api/v1/rpm/pool-balances/:poolId");
    writeln("    GET    /api/v1/rpm/kpis");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
