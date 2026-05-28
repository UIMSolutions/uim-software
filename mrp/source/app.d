/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module app;

import uim.platform.mrp;

void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    container.materialController.registerRoutes(router);
    container.plantController.registerRoutes(router);
    container.billOfMaterialController.registerRoutes(router);
    container.inventoryPositionController.registerRoutes(router);
    container.mrpRunController.registerRoutes(router);
    container.procurementProposalController.registerRoutes(router);
    container.healthController.registerRoutes(router);

    writeln("====================================================");
    writeln("  SAP Material Requirements Planning (PP-MRP) Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /api/v1/mrp/materials");
    writeln("    POST   /api/v1/mrp/materials");
    writeln("    GET    /api/v1/mrp/materials/:id");
    writeln("    PUT    /api/v1/mrp/materials/:id");
    writeln("    DELETE /api/v1/mrp/materials/:id");
    writeln("    GET    /api/v1/mrp/plants");
    writeln("    POST   /api/v1/mrp/plants");
    writeln("    GET    /api/v1/mrp/plants/:id");
    writeln("    PUT    /api/v1/mrp/plants/:id");
    writeln("    DELETE /api/v1/mrp/plants/:id");
    writeln("    GET    /api/v1/mrp/bills-of-material");
    writeln("    POST   /api/v1/mrp/bills-of-material");
    writeln("    GET    /api/v1/mrp/bills-of-material/:id");
    writeln("    PUT    /api/v1/mrp/bills-of-material/:id");
    writeln("    DELETE /api/v1/mrp/bills-of-material/:id");
    writeln("    GET    /api/v1/mrp/inventory-positions");
    writeln("    POST   /api/v1/mrp/inventory-positions");
    writeln("    GET    /api/v1/mrp/inventory-positions/:id");
    writeln("    PUT    /api/v1/mrp/inventory-positions/:id");
    writeln("    DELETE /api/v1/mrp/inventory-positions/:id");
    writeln("    GET    /api/v1/mrp/runs");
    writeln("    POST   /api/v1/mrp/runs");
    writeln("    GET    /api/v1/mrp/runs/:id");
    writeln("    PUT    /api/v1/mrp/runs/:id");
    writeln("    DELETE /api/v1/mrp/runs/:id");
    writeln("    GET    /api/v1/mrp/procurement-proposals");
    writeln("    POST   /api/v1/mrp/procurement-proposals");
    writeln("    GET    /api/v1/mrp/procurement-proposals/:id");
    writeln("    PUT    /api/v1/mrp/procurement-proposals/:id");
    writeln("    DELETE /api/v1/mrp/procurement-proposals/:id");
    writeln("    GET    /health");
    writeln("====================================================");
    writefln("  Listening on %s:%d", config.host, config.port);
    writeln("====================================================");

    auto settings = new HTTPServerSettings();
    settings.port = config.port;
    settings.bindAddresses = [config.host];
    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
}
