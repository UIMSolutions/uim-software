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
import uim.platform.ibp;

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
    writeln("  Integrated Business Planning Service (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/ibp/demand-plans");
    writeln("    POST   /api/v1/ibp/demand-plans");
    writeln("    GET    /api/v1/ibp/supply-plans");
    writeln("    POST   /api/v1/ibp/supply-plans");
    writeln("    GET    /api/v1/ibp/response-plans");
    writeln("    POST   /api/v1/ibp/response-plans");
    writeln("    GET    /api/v1/ibp/inventory-plans");
    writeln("    POST   /api/v1/ibp/inventory-plans");
    writeln("    GET    /api/v1/ibp/scenario-simulations");
    writeln("    POST   /api/v1/ibp/scenario-simulations");
    writeln("    GET    /api/v1/ibp/sop-cycles");
    writeln("    POST   /api/v1/ibp/sop-cycles");
    writeln("    GET    /api/v1/ibp/collaboration-workspaces");
    writeln("    POST   /api/v1/ibp/collaboration-workspaces");
    writeln("    GET    /api/v1/ibp/planning-areas");
    writeln("    POST   /api/v1/ibp/planning-areas");
    writeln("    POST   /api/v1/ibp/integrations/master-data-sync/:demandPlanId");
    writeln("    POST   /api/v1/ibp/integrations/analytics-sync/:scenarioId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
