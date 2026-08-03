module app;

import std.stdio : writeln;
import vibe.core.core : runApplication;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerSettings, listenHTTP;
import uim.platform.spreadsheet;

version(unittest) {
} else {
    void main() {
        auto config = loadConfig();
        auto container = buildContainer(config);

        auto router = new URLRouter();
        container.healthController.registerRoutes(router);
        container.apiController.registerRoutes(router);

        auto settings = new HTTPServerSettings();
        settings.bindAddresses = [config.host];
        settings.port = config.port;

        writeln("====================================================");
        writeln("  Spreadsheet Analytics Service");
        writeln("====================================================");
        writeln("  Endpoints:");
        writeln("    GET    /");
        writeln("    GET    /health");
        writeln("    GET    /api/v1/health");
        writeln("    GET    /api/v1/spreadsheets");
        writeln("    GET    /api/v1/spreadsheets/:id");
        writeln("    POST   /api/v1/spreadsheets");
        writeln("    PUT    /api/v1/spreadsheets/:id");
        writeln("    DELETE /api/v1/spreadsheets/:id");
        writeln("    GET    /api/v1/spreadsheets/:id/metrics");
        writeln("====================================================");
        writeln("  Listening on ", config.host, ":", config.port);
        writeln("====================================================");

        auto listener = listenHTTP(settings, router);
        scope(exit) listener.stopListening();
        runApplication();
    }
}
