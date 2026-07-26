/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module app;

import uim.platform.lean;

void main() {
    import std.stdio : writeln;

    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    container.healthController.registerRoutes(router);
    container.objectiveController.registerRoutes(router);
    container.platformController.registerRoutes(router);
    container.initiativeController.registerRoutes(router);
    container.organizationController.registerRoutes(router);
    container.businessCapabilityController.registerRoutes(router);
    container.businessContextController.registerRoutes(router);
    container.dataObjectController.registerRoutes(router);
    container.applicationController.registerRoutes(router);
    container.interfaceController.registerRoutes(router);
    container.providerController.registerRoutes(router);
    container.itComponentController.registerRoutes(router);
    container.techCategoryController.registerRoutes(router);
    container.leanWebController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("UIM LEAN Platform Service starting on ", config.host, ":", config.port);
    writeln("Endpoints:");
    writeln("  GET    /api/v1/health");
    writeln("  GET    /api/v1/lean/objectives");
    writeln("  GET    /api/v1/lean/objectives/*");
    writeln("  POST   /api/v1/lean/objectives");
    writeln("  PUT    /api/v1/lean/objectives/*");
    writeln("  DELETE /api/v1/lean/objectives/*");
    writeln("  GET    /api/v1/lean/platforms");
    writeln("  GET    /api/v1/lean/platforms/*");
    writeln("  POST   /api/v1/lean/platforms");
    writeln("  PUT    /api/v1/lean/platforms/*");
    writeln("  DELETE /api/v1/lean/platforms/*");
    writeln("  GET    /api/v1/lean/initiatives");
    writeln("  GET    /api/v1/lean/initiatives/*");
    writeln("  POST   /api/v1/lean/initiatives");
    writeln("  PUT    /api/v1/lean/initiatives/*");
    writeln("  DELETE /api/v1/lean/initiatives/*");
    writeln("  GET    /api/v1/lean/organizations");
    writeln("  GET    /api/v1/lean/organizations/*");
    writeln("  POST   /api/v1/lean/organizations");
    writeln("  PUT    /api/v1/lean/organizations/*");
    writeln("  DELETE /api/v1/lean/organizations/*");
    writeln("  GET    /api/v1/lean/business-capabilities");
    writeln("  GET    /api/v1/lean/business-capabilities/*");
    writeln("  POST   /api/v1/lean/business-capabilities");
    writeln("  PUT    /api/v1/lean/business-capabilities/*");
    writeln("  DELETE /api/v1/lean/business-capabilities/*");
    writeln("  GET    /api/v1/lean/business-contexts");
    writeln("  GET    /api/v1/lean/business-contexts/*");
    writeln("  POST   /api/v1/lean/business-contexts");
    writeln("  PUT    /api/v1/lean/business-contexts/*");
    writeln("  DELETE /api/v1/lean/business-contexts/*");
    writeln("  GET    /api/v1/lean/data-objects");
    writeln("  GET    /api/v1/lean/data-objects/*");
    writeln("  POST   /api/v1/lean/data-objects");
    writeln("  PUT    /api/v1/lean/data-objects/*");
    writeln("  DELETE /api/v1/lean/data-objects/*");
    writeln("  GET    /api/v1/lean/applications");
    writeln("  GET    /api/v1/lean/applications/*");
    writeln("  POST   /api/v1/lean/applications");
    writeln("  PUT    /api/v1/lean/applications/*");
    writeln("  DELETE /api/v1/lean/applications/*");
    writeln("  GET    /api/v1/lean/interfaces");
    writeln("  GET    /api/v1/lean/interfaces/*");
    writeln("  POST   /api/v1/lean/interfaces");
    writeln("  PUT    /api/v1/lean/interfaces/*");
    writeln("  DELETE /api/v1/lean/interfaces/*");
    writeln("  GET    /api/v1/lean/providers");
    writeln("  GET    /api/v1/lean/providers/*");
    writeln("  POST   /api/v1/lean/providers");
    writeln("  PUT    /api/v1/lean/providers/*");
    writeln("  DELETE /api/v1/lean/providers/*");
    writeln("  GET    /api/v1/lean/it-components");
    writeln("  GET    /api/v1/lean/it-components/*");
    writeln("  POST   /api/v1/lean/it-components");
    writeln("  PUT    /api/v1/lean/it-components/*");
    writeln("  DELETE /api/v1/lean/it-components/*");
    writeln("  GET    /api/v1/lean/tech-categories");
    writeln("  GET    /api/v1/lean/tech-categories/*");
    writeln("  POST   /api/v1/lean/tech-categories");
    writeln("  PUT    /api/v1/lean/tech-categories/*");
    writeln("  DELETE /api/v1/lean/tech-categories/*");
    writeln("  GET    /web/lean");
    writeln("  GET    /web/lean/*");

    listenHTTP(settings, router);
    runApplication();
}
