module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.ppm;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();
    container.healthController.registerRoutes(router);
    container.portfolioController.registerRoutes(router);
    container.initiativeController.registerRoutes(router);
    container.programController.registerRoutes(router);
    container.projectController.registerRoutes(router);
    container.demandController.registerRoutes(router);
    container.resourceRequestController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Enterprise Portfolio and Project Management");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/ppm/portfolios");
    writeln("    POST   /api/v1/ppm/portfolios");
    writeln("    GET    /api/v1/ppm/initiatives");
    writeln("    POST   /api/v1/ppm/initiatives");
    writeln("    GET    /api/v1/ppm/programs");
    writeln("    POST   /api/v1/ppm/programs");
    writeln("    GET    /api/v1/ppm/projects");
    writeln("    POST   /api/v1/ppm/projects");
    writeln("    GET    /api/v1/ppm/demands");
    writeln("    POST   /api/v1/ppm/demands");
    writeln("    GET    /api/v1/ppm/resource-requests");
    writeln("    POST   /api/v1/ppm/resource-requests");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
