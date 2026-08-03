module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.bw;

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
    writeln("  Business Warehouse Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /ui");
    writeln("    CRUD   /api/v1/bw/<objectType>");
    writeln("    GET    /api/v1/bw/search/models?q=<query>");
    writeln("    GET    /api/v1/bw/data-flows/by-source/:sourceId");
    writeln("    GET    /api/v1/bw/queries/by-provider/:providerId");
    writeln("    POST   /api/v1/bw/query-executions");
    writeln("    GET    /api/v1/bw/api-catalog");
    writeln("====================================================");
    writeln("  Query Runtime URL: ", config.queryRuntimeUrl.length ? config.queryRuntimeUrl : "<simulated>");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
