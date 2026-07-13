module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.verinice;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();
    container.healthController.registerRoutes(router);
    container.assetController.registerRoutes(router);
    container.safeguardController.registerRoutes(router);
    container.assessmentController.registerRoutes(router);
    container.integrationController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Verinice IT-Grundschutz Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/verinice/assets");
    writeln("    POST   /api/v1/verinice/assets");
    writeln("    GET    /api/v1/verinice/safeguards");
    writeln("    POST   /api/v1/verinice/safeguards");
    writeln("    GET    /api/v1/verinice/assessments");
    writeln("    POST   /api/v1/verinice/assessments");
    writeln("    POST   /api/v1/verinice/integrations/gs-catalog-sync/:safeguardId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
