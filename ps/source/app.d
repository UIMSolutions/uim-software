/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module app;

import uim.platform.ps;

void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    container.projectController.registerRoutes(router);
    container.wbsElementController.registerRoutes(router);
    container.networkActivityController.registerRoutes(router);
    container.milestoneController.registerRoutes(router);
    container.projectCostController.registerRoutes(router);
    container.projectBudgetController.registerRoutes(router);
    container.healthController.registerRoutes(router);

    writeln("====================================================");
    writeln("  SAP Project System (PS) Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /api/v1/ps/projects");
    writeln("    POST   /api/v1/ps/projects");
    writeln("    GET    /api/v1/ps/projects/:id");
    writeln("    PUT    /api/v1/ps/projects/:id");
    writeln("    DELETE /api/v1/ps/projects/:id");
    writeln("    GET    /api/v1/ps/wbs-elements");
    writeln("    POST   /api/v1/ps/wbs-elements");
    writeln("    GET    /api/v1/ps/wbs-elements/:id");
    writeln("    PUT    /api/v1/ps/wbs-elements/:id");
    writeln("    DELETE /api/v1/ps/wbs-elements/:id");
    writeln("    GET    /api/v1/ps/network-activities");
    writeln("    POST   /api/v1/ps/network-activities");
    writeln("    GET    /api/v1/ps/network-activities/:id");
    writeln("    PUT    /api/v1/ps/network-activities/:id");
    writeln("    DELETE /api/v1/ps/network-activities/:id");
    writeln("    GET    /api/v1/ps/milestones");
    writeln("    POST   /api/v1/ps/milestones");
    writeln("    GET    /api/v1/ps/milestones/:id");
    writeln("    PUT    /api/v1/ps/milestones/:id");
    writeln("    DELETE /api/v1/ps/milestones/:id");
    writeln("    GET    /api/v1/ps/costs");
    writeln("    POST   /api/v1/ps/costs");
    writeln("    GET    /api/v1/ps/costs/:id");
    writeln("    PUT    /api/v1/ps/costs/:id");
    writeln("    DELETE /api/v1/ps/costs/:id");
    writeln("    GET    /api/v1/ps/budgets");
    writeln("    POST   /api/v1/ps/budgets");
    writeln("    GET    /api/v1/ps/budgets/:id");
    writeln("    PUT    /api/v1/ps/budgets/:id");
    writeln("    DELETE /api/v1/ps/budgets/:id");
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
