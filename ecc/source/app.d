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
import uim.platform.ecc;

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
    writeln("  Engineering Control Center Service (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/ecc/materials");
    writeln("    POST   /api/v1/ecc/materials");
    writeln("    GET    /api/v1/ecc/boms");
    writeln("    POST   /api/v1/ecc/boms");
    writeln("    GET    /api/v1/ecc/change-requests");
    writeln("    POST   /api/v1/ecc/change-requests");
    writeln("    GET    /api/v1/ecc/documents");
    writeln("    POST   /api/v1/ecc/documents");
    writeln("    GET    /api/v1/ecc/document-attributes");
    writeln("    POST   /api/v1/ecc/document-attributes");
    writeln("    GET    /api/v1/ecc/cad-items");
    writeln("    POST   /api/v1/ecc/cad-items");
    writeln("    GET    /api/v1/ecc/workspaces");
    writeln("    POST   /api/v1/ecc/workspaces");
    writeln("    GET    /api/v1/ecc/assembly-structures");
    writeln("    POST   /api/v1/ecc/assembly-structures");
    writeln("    POST   /api/v1/ecc/integrations/material-master-sync/:productId");
    writeln("    POST   /api/v1/ecc/integrations/document-info-record-sync/:specificationId");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
