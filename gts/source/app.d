module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;

import uim.platform.gts;

version(unittest) {
} else
void main() {
    auto config = loadConfig();
    auto container = buildContainer(config);

    auto router = new URLRouter();
    container.healthController.registerRoutes(router);
    container.businessPartnerController.registerRoutes(router);
    container.productClassificationController.registerRoutes(router);
    container.customsDeclarationController.registerRoutes(router);
    container.tradeLicenseController.registerRoutes(router);
    container.preferenceAgreementController.registerRoutes(router);
    container.sanctionedPartyCaseController.registerRoutes(router);
    container.embargoControlCaseController.registerRoutes(router);
    container.intrastatDeclarationController.registerRoutes(router);

    auto settings = new HTTPServerSettings();
    settings.bindAddresses = [config.host];
    settings.port = config.port;

    writeln("====================================================");
    writeln("  Global Trade Services (SAP-inspired)");
    writeln("====================================================");
    writeln("  Endpoints:");
    writeln("    GET    /health");
    writeln("    GET    /api/v1/health");
    writeln("    CRUD   /api/v1/gts/business-partners");
    writeln("    CRUD   /api/v1/gts/product-classifications");
    writeln("    CRUD   /api/v1/gts/customs-declarations");
    writeln("    CRUD   /api/v1/gts/trade-licenses");
    writeln("    CRUD   /api/v1/gts/preference-agreements");
    writeln("    CRUD   /api/v1/gts/sanctioned-party-cases");
    writeln("    CRUD   /api/v1/gts/embargo-control-cases");
    writeln("    CRUD   /api/v1/gts/intrastat-declarations");
    writeln("====================================================");
    writeln("  Listening on ", config.host, ":", config.port);
    writeln("====================================================");

    auto listener = listenHTTP(settings, router);
    scope (exit) listener.stopListening();
    runApplication();
}
