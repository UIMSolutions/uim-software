/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module app;

import std.stdio : writeln;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import vibe.core.core : runApplication;
import uim.platform.defense;

void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    container.healthController.registerRoutes(router);
    container.missionPlanController.registerRoutes(router);
    container.exerciseController.registerRoutes(router);
    container.contingentController.registerRoutes(router);
    container.readinessController.registerRoutes(router);
    container.redeploymentOrderController.registerRoutes(router);
    container.maintenanceTaskController.registerRoutes(router);
    container.budgetTriggerController.registerRoutes(router);
    container.offlineSyncRecordController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [container.config.host];
    settings.port = container.config.port;

    writeln("====================================================");
    writeln("  Defense & Security Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/defense/missions");
    writeln("    POST   /api/v1/defense/missions");
    writeln("    GET    /api/v1/defense/missions/:id");
    writeln("    PUT    /api/v1/defense/missions/:id");
    writeln("    DELETE /api/v1/defense/missions/:id");
    writeln("    GET    /api/v1/defense/exercises");
    writeln("    POST   /api/v1/defense/exercises");
    writeln("    GET    /api/v1/defense/exercises/:id");
    writeln("    PUT    /api/v1/defense/exercises/:id");
    writeln("    DELETE /api/v1/defense/exercises/:id");
    writeln("    GET    /api/v1/defense/contingents");
    writeln("    POST   /api/v1/defense/contingents");
    writeln("    GET    /api/v1/defense/contingents/:id");
    writeln("    PUT    /api/v1/defense/contingents/:id");
    writeln("    DELETE /api/v1/defense/contingents/:id");
    writeln("    GET    /api/v1/defense/readiness");
    writeln("    POST   /api/v1/defense/readiness");
    writeln("    GET    /api/v1/defense/readiness/:id");
    writeln("    PUT    /api/v1/defense/readiness/:id");
    writeln("    DELETE /api/v1/defense/readiness/:id");
    writeln("    GET    /api/v1/defense/redeployment-orders");
    writeln("    POST   /api/v1/defense/redeployment-orders");
    writeln("    GET    /api/v1/defense/redeployment-orders/:id");
    writeln("    PUT    /api/v1/defense/redeployment-orders/:id");
    writeln("    DELETE /api/v1/defense/redeployment-orders/:id");
    writeln("    GET    /api/v1/defense/maintenance-tasks");
    writeln("    POST   /api/v1/defense/maintenance-tasks");
    writeln("    GET    /api/v1/defense/maintenance-tasks/:id");
    writeln("    PUT    /api/v1/defense/maintenance-tasks/:id");
    writeln("    DELETE /api/v1/defense/maintenance-tasks/:id");
    writeln("    GET    /api/v1/defense/budget-triggers");
    writeln("    POST   /api/v1/defense/budget-triggers");
    writeln("    GET    /api/v1/defense/budget-triggers/:id");
    writeln("    PUT    /api/v1/defense/budget-triggers/:id");
    writeln("    DELETE /api/v1/defense/budget-triggers/:id");
    writeln("    GET    /api/v1/defense/offline-sync-records");
    writeln("    POST   /api/v1/defense/offline-sync-records");
    writeln("    GET    /api/v1/defense/offline-sync-records/:id");
    writeln("    PUT    /api/v1/defense/offline-sync-records/:id");
    writeln("    DELETE /api/v1/defense/offline-sync-records/:id");
    writeln("====================================================");
    writeln("  Listening on ", container.config.host, ":", container.config.port);
    writeln("====================================================");

    listenHTTP(settings, router);
    runApplication();
}
