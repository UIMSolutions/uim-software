module uim.platform.spreadsheet.presentation.http.spreadsheet_controller;

import std.algorithm.searching : endsWith, startsWith;
import std.conv : to;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse;
import uim.platform.spreadsheet.application.usecases.spreadsheet_service;

class SpreadsheetApiController {
    private SpreadsheetService service;

    this(SpreadsheetService service) {
        this.service = service;
    }

    void registerRoutes(URLRouter router) {
        router.get("/api/v1/spreadsheets", &listHandler);
        router.get("/api/v1/spreadsheets/*", &resourceHandler);
        router.post("/api/v1/spreadsheets", &createHandler);
        router.put("/api/v1/spreadsheets/*", &updateHandler);
        router.delete_("/api/v1/spreadsheets/*", &deleteHandler);
    }

    void listHandler(HTTPServerRequest req, HTTPServerResponse res) {
        auto sheets = service.list();
        res.writeJsonBody(sheets, 200);
    }

    void resourceHandler(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractId(req.requestPath.to!string);
        if (id.length == 0) {
            res.writeJsonBody(["error": "not_found"], 404);
            return;
        }

        if (req.requestPath.to!string.endsWith("/metrics")) {
            metricsHandler(req, res, id);
            return;
        }

        auto sheet = service.get(id);
        if (sheet.id.length == 0) {
            res.writeJsonBody(["error": "not_found"], 404);
            return;
        }
        res.writeJsonBody(sheet, 200);
    }

    void createHandler(HTTPServerRequest req, HTTPServerResponse res) {
        auto payload = req.json;
        auto sheet = service.create(payload["name"].get!string, payload["description"].get!string, payload["owner"].get!string, [], [], []);
        res.writeJsonBody(sheet, 201);
    }

    void updateHandler(HTTPServerRequest req, HTTPServerResponse res) {
        auto payload = req.json;
        auto id = extractId(req.requestPath.to!string);
        auto sheet = service.update(id, payload["name"].get!string, payload["description"].get!string, payload["owner"].get!string, [], [], []);
        res.writeJsonBody(sheet, 200);
    }

    void deleteHandler(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractId(req.requestPath.to!string);
        auto deleted = service.remove(id);
        res.writeJsonBody(["deleted": deleted], 200);
    }

    void metricsHandler(HTTPServerRequest req, HTTPServerResponse res, string id = "") {
        auto resolvedId = id.length > 0 ? id : extractId(req.requestPath.to!string);
        res.writeJsonBody(["metrics": service.metrics(resolvedId)], 200);
    }

    private string extractId(string path) {
        string normalized = path;
        if (normalized.startsWith("/")) normalized = normalized[1 .. $];
        immutable prefix = "api/v1/spreadsheets/";
        if (!normalized.startsWith(prefix)) return "";

        auto rest = normalized[prefix.length .. $];
        if (rest.startsWith("/")) rest = rest[1 .. $];
        if (rest.endsWith("/metrics")) rest = rest[0 .. $ - "/metrics".length];
        if (rest.endsWith("/")) rest = rest[0 .. $ - 1];
        return rest;
    }
}
