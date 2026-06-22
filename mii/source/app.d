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
import uim.platform.mii;

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
    writeln("  Manufacturing Integration and Intelligence Service (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/mii/production-messages");
    writeln("    POST   /api/v1/mii/production-messages");
    writeln("    GET    /api/v1/mii/work-center-events");
    writeln("    POST   /api/v1/mii/work-center-events");
    writeln("    GET    /api/v1/mii/data-collections");
    writeln("    POST   /api/v1/mii/data-collections");
    writeln("    GET    /api/v1/mii/kpi-observations");
    writeln("    POST   /api/v1/mii/kpi-observations");
    writeln("    GET    /api/v1/mii/alert-notifications");
    writeln("    POST   /api/v1/mii/alert-notifications");
    writeln("    GET    /api/v1/mii/workflow-instances");
    writeln("    POST   /api/v1/mii/workflow-instances");
    writeln("    GET    /api/v1/mii/dashboard-widgets");
    writeln("    POST   /api/v1/mii/dashboard-widgets");
    writeln("    GET    /api/v1/mii/integration-endpoints");
    writeln("    POST   /api/v1/mii/integration-endpoints");
    writeln("    POST   /api/v1/mii/integrations/erp-message-sync/:messageId");
    writeln("    POST   /api/v1/mii/integrations/analytics-sync/:alertId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
