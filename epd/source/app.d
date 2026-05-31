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
import uim.platform.epd;

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
    writeln("  Integrated Product Development Service (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/epd/products");
    writeln("    POST   /api/v1/epd/products");
    writeln("    GET    /api/v1/epd/boms");
    writeln("    POST   /api/v1/epd/boms");
    writeln("    GET    /api/v1/epd/change-requests");
    writeln("    POST   /api/v1/epd/change-requests");
    writeln("    GET    /api/v1/epd/documents");
    writeln("    POST   /api/v1/epd/documents");
    writeln("    GET    /api/v1/epd/specifications");
    writeln("    POST   /api/v1/epd/specifications");
    writeln("    GET    /api/v1/epd/recipes");
    writeln("    POST   /api/v1/epd/recipes");
    writeln("    GET    /api/v1/epd/collaborations");
    writeln("    POST   /api/v1/epd/collaborations");
    writeln("    GET    /api/v1/epd/product-structures");
    writeln("    POST   /api/v1/epd/product-structures");
    writeln("    POST   /api/v1/epd/integrations/product-handover/:productId");
    writeln("    POST   /api/v1/epd/integrations/specification-sync/:specificationId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
