module app;

import std.stdio : writeln;

import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;

import uim.platform.alm;

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
    writeln("  Solution Lifecycle Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/alm/solutions");
    writeln("    POST   /api/v1/alm/solutions");
    writeln("    GET    /api/v1/alm/solutions/*");
    writeln("    PUT    /api/v1/alm/solutions/*");
    writeln("    DELETE /api/v1/alm/solutions/*");
    writeln("    GET    /api/v1/alm/projects");
    writeln("    POST   /api/v1/alm/projects");
    writeln("    GET    /api/v1/alm/tasks");
    writeln("    POST   /api/v1/alm/tasks");
    writeln("    GET    /api/v1/alm/test-plans");
    writeln("    POST   /api/v1/alm/test-plans");
    writeln("    GET    /api/v1/alm/test-cases");
    writeln("    POST   /api/v1/alm/test-cases");
    writeln("    GET    /api/v1/alm/defects");
    writeln("    POST   /api/v1/alm/defects");
    writeln("    GET    /api/v1/alm/releases");
    writeln("    POST   /api/v1/alm/releases");
    writeln("    GET    /api/v1/alm/deployments");
    writeln("    POST   /api/v1/alm/deployments");
    writeln("    GET    /api/v1/alm/environments");
    writeln("    POST   /api/v1/alm/environments");
    writeln("    GET    /api/v1/alm/alerts");
    writeln("    POST   /api/v1/alm/alerts");
    writeln("    GET    /api/v1/alm/summary");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
