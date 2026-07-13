module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.maif;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    container.healthController.registerRoutes(router);
    container.mobileAppController.registerRoutes(router);
    container.integrationFlowController.registerRoutes(router);
    container.syncJobController.registerRoutes(router);
    container.integrationController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Mobile Application Integration Framework Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/maif/mobile-apps");
    writeln("    POST   /api/v1/maif/mobile-apps");
    writeln("    GET    /api/v1/maif/mobile-apps/:id");
    writeln("    PUT    /api/v1/maif/mobile-apps/:id");
    writeln("    DELETE /api/v1/maif/mobile-apps/:id");
    writeln("    GET    /api/v1/maif/integration-flows");
    writeln("    POST   /api/v1/maif/integration-flows");
    writeln("    GET    /api/v1/maif/integration-flows/:id");
    writeln("    PUT    /api/v1/maif/integration-flows/:id");
    writeln("    DELETE /api/v1/maif/integration-flows/:id");
    writeln("    GET    /api/v1/maif/sync-jobs");
    writeln("    POST   /api/v1/maif/sync-jobs");
    writeln("    GET    /api/v1/maif/sync-jobs/:id");
    writeln("    PUT    /api/v1/maif/sync-jobs/:id");
    writeln("    DELETE /api/v1/maif/sync-jobs/:id");
    writeln("    POST   /api/v1/maif/integrations/publish-mobile-app/:appId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
