module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.freight_collaboration;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();
    container.healthController.registerRoutes(router);
    container.freightOrderController.registerRoutes(router);
    container.tenderController.registerRoutes(router);
    container.milestoneController.registerRoutes(router);
    container.integrationController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  SAP Business Network Freight Collaboration Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/freight-collaboration/freight-orders");
    writeln("    POST   /api/v1/freight-collaboration/freight-orders");
    writeln("    GET    /api/v1/freight-collaboration/tenders");
    writeln("    POST   /api/v1/freight-collaboration/tenders");
    writeln("    GET    /api/v1/freight-collaboration/milestones");
    writeln("    POST   /api/v1/freight-collaboration/milestones");
    writeln("    POST   /api/v1/freight-collaboration/integrations/tender-sync/:tenderId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
