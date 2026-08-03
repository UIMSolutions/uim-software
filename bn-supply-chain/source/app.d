module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.bn_supply_chain;

version(unittest) {
} else {
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
        writeln("  Supply Chain Network Service");
        writeln("====================================================");
        writeln("  Endpoints:");
        writeln("    GET    /");
        writeln("    GET    /health");
        writeln("    GET    /api/v1/health");
        writeln("    GET    /api/v1/partners");
        writeln("    GET    /api/v1/orders");
        writeln("    GET    /api/v1/shipments");
        writeln("    GET    /api/v1/ship-notices");
        writeln("    GET    /api/v1/invoices");
        writeln("    GET    /api/v1/alerts");
        writeln("====================================================");
        writeln("  Listening on ", config.host, ":", config.port);
        writeln("====================================================");

        auto listener = listenHTTP(settings, router);
        scope(exit) listener.stopListening();
        runApplication();
    }
}
