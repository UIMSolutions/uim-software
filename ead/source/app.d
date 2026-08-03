module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.ead;

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
    writeln("  Enterprise Architecture Designer Cloud Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /ui");
    writeln("    CRUD   /api/v1/ead/<objectType>");
    writeln("    GET    /api/v1/ead/search/models?q=<query>");
    writeln("    GET    /api/v1/ead/dependencies/by-source/:sourceId");
    writeln("    GET    /api/v1/ead/impacts/by-target/:targetId");
    writeln("    GET    /api/v1/ead/viewpoints/by-layer/:layer");
    writeln("    POST   /api/v1/ead/diagram-renderings");
    writeln("    GET    /api/v1/ead/api-catalog");
    writeln("    GET    /api/v1/ead/openapi.json");
    writeln("====================================================");
    writeln("  Diagram Runtime URL: ", config.diagramRuntimeUrl.length ? config.diagramRuntimeUrl : "<simulated>");
    writeln("  OpenAPI export path: ", config.openApiExportPath);
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
