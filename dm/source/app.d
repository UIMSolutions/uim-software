module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;

import uim.platform.dm;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();
    container.healthController.registerRoutes(router);
    container.productionOrderController.registerRoutes(router);
    container.operationActivityController.registerRoutes(router);
    container.workCenterController.registerRoutes(router);
    container.resourceController.registerRoutes(router);
    container.materialController.registerRoutes(router);
    container.shopFloorControlController.registerRoutes(router);
    container.workInstructionController.registerRoutes(router);
    container.qualityInspectionController.registerRoutes(router);
    container.nonconformanceController.registerRoutes(router);
    container.genealogyRecordController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  SAP Digital Manufacturing Service (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    CRUD   /api/v1/dm/production-orders");
    writeln("    CRUD   /api/v1/dm/operation-activities");
    writeln("    CRUD   /api/v1/dm/work-centers");
    writeln("    CRUD   /api/v1/dm/resources");
    writeln("    CRUD   /api/v1/dm/materials");
    writeln("    CRUD   /api/v1/dm/shop-floor-controls");
    writeln("    CRUD   /api/v1/dm/work-instructions");
    writeln("    CRUD   /api/v1/dm/quality-inspections");
    writeln("    CRUD   /api/v1/dm/nonconformances");
    writeln("    CRUD   /api/v1/dm/genealogy-records");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
