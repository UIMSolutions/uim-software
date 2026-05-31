/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module app;

import std.stdio : writeln;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import vibe.core.core : runApplication;
import uim.platform.mes;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    container.healthController.registerRoutes(router);
    container.productController.registerRoutes(router);
    container.billOfMaterialController.registerRoutes(router);
    container.changeRequestController.registerRoutes(router);
    container.documentController.registerRoutes(router);
    container.specificationController.registerRoutes(router);
    container.recipeController.registerRoutes(router);
    container.collaborationController.registerRoutes(router);
    container.productStructureController.registerRoutes(router);
    container.integrationController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Manufacturing Execution Service (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/mes/production-orders");
    writeln("    POST   /api/v1/mes/production-orders");
    writeln("    GET    /api/v1/mes/operations");
    writeln("    POST   /api/v1/mes/operations");
    writeln("    GET    /api/v1/mes/work-center-assignments");
    writeln("    POST   /api/v1/mes/work-center-assignments");
    writeln("    GET    /api/v1/mes/shop-floor-events");
    writeln("    POST   /api/v1/mes/shop-floor-events");
    writeln("    GET    /api/v1/mes/quality-inspections");
    writeln("    POST   /api/v1/mes/quality-inspections");
    writeln("    GET    /api/v1/mes/batch-records");
    writeln("    POST   /api/v1/mes/batch-records");
    writeln("    GET    /api/v1/mes/operator-collaborations");
    writeln("    POST   /api/v1/mes/operator-collaborations");
    writeln("    GET    /api/v1/mes/production-traceability");
    writeln("    POST   /api/v1/mes/production-traceability");
    writeln("    POST   /api/v1/mes/integrations/order-sync/:orderId");
    writeln("    POST   /api/v1/mes/integrations/quality-sync/:inspectionId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
