/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module app;

import uim.platform.sci;

void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();

    // Register all controllers
    container.instanceController.registerRoutes(router);
    container.volumeController.registerRoutes(router);
    container.networkController.registerRoutes(router);
    container.securityGroupController.registerRoutes(router);
    container.floatingIpController.registerRoutes(router);
    container.loadBalancerController.registerRoutes(router);
    container.dnsZoneController.registerRoutes(router);
    container.keyPairController.registerRoutes(router);
    container.healthController.registerRoutes(router);

    writeln("====================================================");
    writeln("  SAP Cloud Infrastructure Service (SCI)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /api/v1/sci/instances");
    writeln("    POST   /api/v1/sci/instances");
    writeln("    GET    /api/v1/sci/instances/:id");
    writeln("    PUT    /api/v1/sci/instances/:id");
    writeln("    DELETE /api/v1/sci/instances/:id");
    writeln("    GET    /api/v1/sci/volumes");
    writeln("    POST   /api/v1/sci/volumes");
    writeln("    GET    /api/v1/sci/volumes/:id");
    writeln("    PUT    /api/v1/sci/volumes/:id");
    writeln("    DELETE /api/v1/sci/volumes/:id");
    writeln("    GET    /api/v1/sci/networks");
    writeln("    POST   /api/v1/sci/networks");
    writeln("    GET    /api/v1/sci/networks/:id");
    writeln("    PUT    /api/v1/sci/networks/:id");
    writeln("    DELETE /api/v1/sci/networks/:id");
    writeln("    GET    /api/v1/sci/security-groups");
    writeln("    POST   /api/v1/sci/security-groups");
    writeln("    GET    /api/v1/sci/security-groups/:id");
    writeln("    PUT    /api/v1/sci/security-groups/:id");
    writeln("    DELETE /api/v1/sci/security-groups/:id");
    writeln("    GET    /api/v1/sci/floating-ips");
    writeln("    POST   /api/v1/sci/floating-ips");
    writeln("    GET    /api/v1/sci/floating-ips/:id");
    writeln("    PUT    /api/v1/sci/floating-ips/:id");
    writeln("    DELETE /api/v1/sci/floating-ips/:id");
    writeln("    GET    /api/v1/sci/load-balancers");
    writeln("    POST   /api/v1/sci/load-balancers");
    writeln("    GET    /api/v1/sci/load-balancers/:id");
    writeln("    PUT    /api/v1/sci/load-balancers/:id");
    writeln("    DELETE /api/v1/sci/load-balancers/:id");
    writeln("    GET    /api/v1/sci/dns-zones");
    writeln("    POST   /api/v1/sci/dns-zones");
    writeln("    GET    /api/v1/sci/dns-zones/:id");
    writeln("    PUT    /api/v1/sci/dns-zones/:id");
    writeln("    DELETE /api/v1/sci/dns-zones/:id");
    writeln("    GET    /api/v1/sci/key-pairs");
    writeln("    POST   /api/v1/sci/key-pairs");
    writeln("    GET    /api/v1/sci/key-pairs/:id");
    writeln("    PUT    /api/v1/sci/key-pairs/:id");
    writeln("    DELETE /api/v1/sci/key-pairs/:id");
    writeln("    GET    /health");
    writeln("====================================================");
    writefln("  Listening on %s:%d", config.host, config.port);
    writeln("====================================================");

    auto settings = new HTTPServerSettings();
    settings.port = config.port;
    settings.bindAddresses = [config.host];
    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
