/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module app;

import uim.platform.gtt;

void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    // Register all controllers
    container.shipmentController.registerRoutes(router);
    container.deliveryController.registerRoutes(router);
    container.purchaseOrderController.registerRoutes(router);
    container.salesOrderController.registerRoutes(router);
    container.trackingEventController.registerRoutes(router);
    container.trackedProcessController.registerRoutes(router);
    container.locationController.registerRoutes(router);
    container.trackingModelController.registerRoutes(router);
    container.healthController.registerRoutes(router);

    writeln("====================================================");
    writeln("  SAP Global Track and Trace (GTT) Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /api/v1/gtt/shipments");
    writeln("    POST   /api/v1/gtt/shipments");
    writeln("    GET    /api/v1/gtt/shipments/:id");
    writeln("    PUT    /api/v1/gtt/shipments/:id");
    writeln("    DELETE /api/v1/gtt/shipments/:id");
    writeln("    GET    /api/v1/gtt/deliveries");
    writeln("    POST   /api/v1/gtt/deliveries");
    writeln("    GET    /api/v1/gtt/deliveries/:id");
    writeln("    PUT    /api/v1/gtt/deliveries/:id");
    writeln("    DELETE /api/v1/gtt/deliveries/:id");
    writeln("    GET    /api/v1/gtt/purchase-orders");
    writeln("    POST   /api/v1/gtt/purchase-orders");
    writeln("    GET    /api/v1/gtt/purchase-orders/:id");
    writeln("    PUT    /api/v1/gtt/purchase-orders/:id");
    writeln("    DELETE /api/v1/gtt/purchase-orders/:id");
    writeln("    GET    /api/v1/gtt/sales-orders");
    writeln("    POST   /api/v1/gtt/sales-orders");
    writeln("    GET    /api/v1/gtt/sales-orders/:id");
    writeln("    PUT    /api/v1/gtt/sales-orders/:id");
    writeln("    DELETE /api/v1/gtt/sales-orders/:id");
    writeln("    GET    /api/v1/gtt/tracking-events");
    writeln("    POST   /api/v1/gtt/tracking-events");
    writeln("    GET    /api/v1/gtt/tracking-events/:id");
    writeln("    PUT    /api/v1/gtt/tracking-events/:id");
    writeln("    DELETE /api/v1/gtt/tracking-events/:id");
    writeln("    GET    /api/v1/gtt/tracked-processes");
    writeln("    POST   /api/v1/gtt/tracked-processes");
    writeln("    GET    /api/v1/gtt/tracked-processes/:id");
    writeln("    PUT    /api/v1/gtt/tracked-processes/:id");
    writeln("    DELETE /api/v1/gtt/tracked-processes/:id");
    writeln("    GET    /api/v1/gtt/locations");
    writeln("    POST   /api/v1/gtt/locations");
    writeln("    GET    /api/v1/gtt/locations/:id");
    writeln("    PUT    /api/v1/gtt/locations/:id");
    writeln("    DELETE /api/v1/gtt/locations/:id");
    writeln("    GET    /api/v1/gtt/tracking-models");
    writeln("    POST   /api/v1/gtt/tracking-models");
    writeln("    GET    /api/v1/gtt/tracking-models/:id");
    writeln("    PUT    /api/v1/gtt/tracking-models/:id");
    writeln("    DELETE /api/v1/gtt/tracking-models/:id");
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
