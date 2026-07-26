module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;

import uim.platform.workflow;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();
    container.healthController.registerRoutes(router);
    container.openApiController.registerRoutes(router);
    container.webClientController.registerRoutes(router);
    container.workflowDefinitionController.registerRoutes(router);
    container.workflowInstanceController.registerRoutes(router);
    container.workflowTaskController.registerRoutes(router);
    container.approvalDecisionController.registerRoutes(router);
    container.deadlineEscalationController.registerRoutes(router);
    container.workflowSubstitutionController.registerRoutes(router);
    container.workflowContextController.registerRoutes(router);
    container.workflowEventController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  SAP Advanced Workflow Inspired Service");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    GET    /api/v1/openapi.yaml");
    writeln("    GET    /client");
    writeln("    CRUD   /api/v1/workflow/definitions");
    writeln("    CRUD   /api/v1/workflow/instances");
    writeln("    CRUD   /api/v1/workflow/tasks");
    writeln("    CRUD   /api/v1/workflow/decisions");
    writeln("    CRUD   /api/v1/workflow/deadlines");
    writeln("    CRUD   /api/v1/workflow/substitutions");
    writeln("    CRUD   /api/v1/workflow/contexts");
    writeln("    CRUD   /api/v1/workflow/events");
    writeln("    CRUD   /api/v1/sap-advanced-workflow/* (compatibility)");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
