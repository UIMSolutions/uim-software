module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.etd;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    container.healthController.registerRoutes(router);
    container.incidentController.registerRoutes(router);
    container.threatIndicatorController.registerRoutes(router);
    container.detectionRuleController.registerRoutes(router);
    container.integrationController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Enterprise Threat Detection Service (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/etd/incidents");
    writeln("    POST   /api/v1/etd/incidents");
    writeln("    GET    /api/v1/etd/incidents/:id");
    writeln("    PUT    /api/v1/etd/incidents/:id");
    writeln("    DELETE /api/v1/etd/incidents/:id");
    writeln("    GET    /api/v1/etd/threat-indicators");
    writeln("    POST   /api/v1/etd/threat-indicators");
    writeln("    GET    /api/v1/etd/threat-indicators/:id");
    writeln("    PUT    /api/v1/etd/threat-indicators/:id");
    writeln("    DELETE /api/v1/etd/threat-indicators/:id");
    writeln("    GET    /api/v1/etd/detection-rules");
    writeln("    POST   /api/v1/etd/detection-rules");
    writeln("    GET    /api/v1/etd/detection-rules/:id");
    writeln("    PUT    /api/v1/etd/detection-rules/:id");
    writeln("    DELETE /api/v1/etd/detection-rules/:id");
    writeln("    POST   /api/v1/etd/integrations/threat-intel-sync/:indicatorId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
