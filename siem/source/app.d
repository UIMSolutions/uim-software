/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module app;

import uim.platform.siem;

void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    // Register all controllers
    container.securityEventController.registerRoutes(router);
    container.alertController.registerRoutes(router);
    container.incidentController.registerRoutes(router);
    container.correlationRuleController.registerRoutes(router);
    container.assetController.registerRoutes(router);
    container.threatIndicatorController.registerRoutes(router);
    container.healthController.registerRoutes(router);

    writeln("====================================================");
    writeln("  Security Information and Event Management (SIEM)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /api/v1/siem/security-events");
    writeln("    POST   /api/v1/siem/security-events");
    writeln("    GET    /api/v1/siem/security-events/:id");
    writeln("    PUT    /api/v1/siem/security-events/:id");
    writeln("    DELETE /api/v1/siem/security-events/:id");
    writeln("    GET    /api/v1/siem/alerts");
    writeln("    POST   /api/v1/siem/alerts");
    writeln("    GET    /api/v1/siem/alerts/:id");
    writeln("    PUT    /api/v1/siem/alerts/:id");
    writeln("    DELETE /api/v1/siem/alerts/:id");
    writeln("    GET    /api/v1/siem/incidents");
    writeln("    POST   /api/v1/siem/incidents");
    writeln("    GET    /api/v1/siem/incidents/:id");
    writeln("    PUT    /api/v1/siem/incidents/:id");
    writeln("    DELETE /api/v1/siem/incidents/:id");
    writeln("    GET    /api/v1/siem/correlation-rules");
    writeln("    POST   /api/v1/siem/correlation-rules");
    writeln("    GET    /api/v1/siem/correlation-rules/:id");
    writeln("    PUT    /api/v1/siem/correlation-rules/:id");
    writeln("    DELETE /api/v1/siem/correlation-rules/:id");
    writeln("    GET    /api/v1/siem/assets");
    writeln("    POST   /api/v1/siem/assets");
    writeln("    GET    /api/v1/siem/assets/:id");
    writeln("    PUT    /api/v1/siem/assets/:id");
    writeln("    DELETE /api/v1/siem/assets/:id");
    writeln("    GET    /api/v1/siem/threat-indicators");
    writeln("    POST   /api/v1/siem/threat-indicators");
    writeln("    GET    /api/v1/siem/threat-indicators/:id");
    writeln("    PUT    /api/v1/siem/threat-indicators/:id");
    writeln("    DELETE /api/v1/siem/threat-indicators/:id");
    writeln("    GET    /api/v1/health");
    writeln("====================================================");

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    listenHTTP(settings, router);
    runApplication();
}
