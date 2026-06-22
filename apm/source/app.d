module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.apm;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();
    container.healthController.registerRoutes(router);
    container.portfolioItemsController.registerRoutes(router);
    container.assessmentsController.registerRoutes(router);
    container.portfolioAnalysisController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Application Portfolio Assessment");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/apm/applications");
    writeln("    POST   /api/v1/apm/applications");
    writeln("    GET    /api/v1/apm/applications/*");
    writeln("    PUT    /api/v1/apm/applications/*");
    writeln("    DELETE /api/v1/apm/applications/*");
    writeln("    GET    /api/v1/apm/assessments");
    writeln("    POST   /api/v1/apm/assessments");
    writeln("    GET    /api/v1/apm/assessments/*");
    writeln("    PUT    /api/v1/apm/assessments/*");
    writeln("    DELETE /api/v1/apm/assessments/*");
    writeln("    GET    /api/v1/apm/portfolio/summary");
    writeln("    GET    /api/v1/apm/portfolio/matrix");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
