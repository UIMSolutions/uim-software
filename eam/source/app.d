/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module app;

import uim.platform.eam;

void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    // Register all controllers
    container.equipmentController.registerRoutes(router);
    container.functionalLocationController.registerRoutes(router);
    container.maintenanceOrderController.registerRoutes(router);
    container.maintenanceNotificationController.registerRoutes(router);
    container.maintenancePlanController.registerRoutes(router);
    container.workCenterController.registerRoutes(router);
    container.materialBOMController.registerRoutes(router);
    container.maintenanceItemController.registerRoutes(router);
    container.healthController.registerRoutes(router);

    writeln("====================================================");
    writeln("  SAP Enterprise Asset Management Service (EAM)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /api/v1/eam/equipment");
    writeln("    POST   /api/v1/eam/equipment");
    writeln("    GET    /api/v1/eam/equipment/:id");
    writeln("    PUT    /api/v1/eam/equipment/:id");
    writeln("    DELETE /api/v1/eam/equipment/:id");
    writeln("    GET    /api/v1/eam/functional-locations");
    writeln("    POST   /api/v1/eam/functional-locations");
    writeln("    GET    /api/v1/eam/functional-locations/:id");
    writeln("    PUT    /api/v1/eam/functional-locations/:id");
    writeln("    DELETE /api/v1/eam/functional-locations/:id");
    writeln("    GET    /api/v1/eam/maintenance-orders");
    writeln("    POST   /api/v1/eam/maintenance-orders");
    writeln("    GET    /api/v1/eam/maintenance-orders/:id");
    writeln("    PUT    /api/v1/eam/maintenance-orders/:id");
    writeln("    DELETE /api/v1/eam/maintenance-orders/:id");
    writeln("    GET    /api/v1/eam/maintenance-notifications");
    writeln("    POST   /api/v1/eam/maintenance-notifications");
    writeln("    GET    /api/v1/eam/maintenance-notifications/:id");
    writeln("    PUT    /api/v1/eam/maintenance-notifications/:id");
    writeln("    DELETE /api/v1/eam/maintenance-notifications/:id");
    writeln("    GET    /api/v1/eam/maintenance-plans");
    writeln("    POST   /api/v1/eam/maintenance-plans");
    writeln("    GET    /api/v1/eam/maintenance-plans/:id");
    writeln("    PUT    /api/v1/eam/maintenance-plans/:id");
    writeln("    DELETE /api/v1/eam/maintenance-plans/:id");
    writeln("    GET    /api/v1/eam/work-centers");
    writeln("    POST   /api/v1/eam/work-centers");
    writeln("    GET    /api/v1/eam/work-centers/:id");
    writeln("    PUT    /api/v1/eam/work-centers/:id");
    writeln("    DELETE /api/v1/eam/work-centers/:id");
    writeln("    GET    /api/v1/eam/material-boms");
    writeln("    POST   /api/v1/eam/material-boms");
    writeln("    GET    /api/v1/eam/material-boms/:id");
    writeln("    PUT    /api/v1/eam/material-boms/:id");
    writeln("    DELETE /api/v1/eam/material-boms/:id");
    writeln("    GET    /api/v1/eam/maintenance-items");
    writeln("    POST   /api/v1/eam/maintenance-items");
    writeln("    GET    /api/v1/eam/maintenance-items/:id");
    writeln("    PUT    /api/v1/eam/maintenance-items/:id");
    writeln("    DELETE /api/v1/eam/maintenance-items/:id");
    writeln("    GET    /health");
    writeln("====================================================");
    writefln("  Listening on %s:%d", config.host, config.port);
    writeln("====================================================");

    auto settings = new HTTPServerSettings();
    settings.port = config.port;
    settings.bindAddresses = [config.host];
    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
