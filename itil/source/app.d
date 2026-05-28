/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
import uim.platform.itil;
import vibe.http.server;
import vibe.http.router;
import vibe.core.core;
import std.stdio : writeln;
import std.format : format;

void main() {
    auto cfg = loadConfig();
    auto container = buildContainer(cfg);

    auto router = new URLRouter();

    // Health
    container.healthController.registerRoutes(router);

    // Domain controllers
    container.itServiceController.registerRoutes(router);
    container.serviceRequestController.registerRoutes(router);
    container.incidentController.registerRoutes(router);
    container.problemController.registerRoutes(router);
    container.changeController.registerRoutes(router);
    container.configurationItemController.registerRoutes(router);
    container.slaController.registerRoutes(router);
    container.knowledgeController.registerRoutes(router);
    container.releaseController.registerRoutes(router);
    container.eventController.registerRoutes(router);
    container.improvementController.registerRoutes(router);
    container.assetController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [cfg.host];
    settings.port = cfg.port;

    writeln("ITIL Platform Service starting on " ~ cfg.host ~ ":" ~ format("%d", cfg.port));
    writeln("Endpoints:");
    writeln("  GET    /api/v1/health");
    writeln("  GET    /api/v1/itil/services");
    writeln("  POST   /api/v1/itil/services");
    writeln("  GET    /api/v1/itil/services/:id");
    writeln("  PUT    /api/v1/itil/services/:id");
    writeln("  DELETE /api/v1/itil/services/:id");
    writeln("  GET    /api/v1/itil/service-requests");
    writeln("  POST   /api/v1/itil/service-requests");
    writeln("  GET    /api/v1/itil/incidents");
    writeln("  POST   /api/v1/itil/incidents");
    writeln("  GET    /api/v1/itil/problems");
    writeln("  POST   /api/v1/itil/problems");
    writeln("  GET    /api/v1/itil/changes");
    writeln("  POST   /api/v1/itil/changes");
    writeln("  GET    /api/v1/itil/configuration-items");
    writeln("  POST   /api/v1/itil/configuration-items");
    writeln("  GET    /api/v1/itil/slas");
    writeln("  POST   /api/v1/itil/slas");
    writeln("  GET    /api/v1/itil/knowledge");
    writeln("  POST   /api/v1/itil/knowledge");
    writeln("  GET    /api/v1/itil/releases");
    writeln("  POST   /api/v1/itil/releases");
    writeln("  GET    /api/v1/itil/events");
    writeln("  POST   /api/v1/itil/events");
    writeln("  GET    /api/v1/itil/improvements");
    writeln("  POST   /api/v1/itil/improvements");
    writeln("  GET    /api/v1/itil/assets");
    writeln("  POST   /api/v1/itil/assets");

    listenHTTP(settings, router);
    runApplication();
}
