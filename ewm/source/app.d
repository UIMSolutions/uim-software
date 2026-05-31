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
import uim.platform.ewm;

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
    writeln("  Warehouse Management Service (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/ewm/warehouses");
    writeln("    POST   /api/v1/ewm/warehouses");
    writeln("    GET    /api/v1/ewm/storage-bins");
    writeln("    POST   /api/v1/ewm/storage-bins");
    writeln("    GET    /api/v1/ewm/warehouse-tasks");
    writeln("    POST   /api/v1/ewm/warehouse-tasks");
    writeln("    GET    /api/v1/ewm/inbound-deliveries");
    writeln("    POST   /api/v1/ewm/inbound-deliveries");
    writeln("    GET    /api/v1/ewm/outbound-deliveries");
    writeln("    POST   /api/v1/ewm/outbound-deliveries");
    writeln("    GET    /api/v1/ewm/handling-units");
    writeln("    POST   /api/v1/ewm/handling-units");
    writeln("    GET    /api/v1/ewm/resource-queues");
    writeln("    POST   /api/v1/ewm/resource-queues");
    writeln("    GET    /api/v1/ewm/stock-items");
    writeln("    POST   /api/v1/ewm/stock-items");
    writeln("    POST   /api/v1/ewm/integrations/warehouse-master-sync/:warehouseId");
    writeln("    POST   /api/v1/ewm/integrations/stock-sync/:stockId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
