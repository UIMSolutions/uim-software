module app;

import std.stdio : writeln, writefln;
import uim.platform.mm;

void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();
    container.masterDataController.registerRoutes(router);
    container.procurementController.registerRoutes(router);
    container.inventoryController.registerRoutes(router);
    container.webClientController.registerRoutes(router);
    container.healthController.registerRoutes(router);

    writeln("===============================================");
    writeln("  SAP Material Management Service (MM)");
    writeln("===============================================");
    writeln("  Endpoints:");
    writeln("    GET    /api/v1/mm/materials");
    writeln("    GET    /api/v1/mm/plants");
    writeln("    GET    /api/v1/mm/storage-locations");
    writeln("    GET    /api/v1/mm/vendors");
    writeln("    GET    /api/v1/mm/purchasing-info-records");
    writeln("    GET    /api/v1/mm/purchase-requisitions");
    writeln("    POST   /api/v1/mm/purchase-requisitions/:id/convert");
    writeln("    GET    /api/v1/mm/purchase-orders");
    writeln("    GET    /api/v1/mm/stock-items");
    writeln("    GET    /api/v1/mm/goods-receipts");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /client");
    writeln("===============================================");
    writefln("  Listening on %s:%d", config.host, config.port);
    writeln("===============================================");

    auto settings = new HTTPServerSettings();
    settings.port = config.port;
    settings.bindAddresses = [config.host];
    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}