module uim.platform.ead.presentation.http.openapi;

import std.file : mkdirRecurse, write;
import std.path : dirName;
import vibe.data.json : Json, serializeToJsonString;

@safe:

Json buildOpenApiSpec() {
    auto spec = Json.emptyObject;
    spec["openapi"] = Json("3.0.3");

    auto info = Json.emptyObject;
    info["title"] = Json("Enterprise Architecture Designer Cloud API");
    info["version"] = Json("1.0.0");
    info["description"] = Json("EAD-style API for architecture repository, dependency analysis, and diagram rendering.");
    spec["info"] = info;

    auto servers = Json.emptyArray;
    auto server = Json.emptyObject;
    server["url"] = Json("http://localhost:8275");
    servers ~= server;
    spec["servers"] = servers;

    auto paths = Json.emptyObject;
    addPath(paths, "/health", "get", "Service health");
    addPath(paths, "/api/v1/health", "get", "Service health (API)");
    addPath(paths, "/api/v1/ead/search/models", "get", "Search architecture models");
    addPath(paths, "/api/v1/ead/dependencies/by-source/{sourceId}", "get", "List dependencies by source");
    addPath(paths, "/api/v1/ead/impacts/by-target/{targetId}", "get", "List impacts by target");
    addPath(paths, "/api/v1/ead/viewpoints/by-layer/{layer}", "get", "List viewpoints by architecture layer");
    addPath(paths, "/api/v1/ead/diagram-renderings", "post", "Render architecture diagram");
    addPath(paths, "/api/v1/ead/api-catalog", "get", "List API definitions from repository");
    addPath(paths, "/api/v1/ead/openapi.json", "get", "Get OpenAPI specification");
    addPath(paths, "/api/v1/ead/{objectType}", "get", "List objects for type");
    addPath(paths, "/api/v1/ead/{objectType}", "post", "Create object for type");
    addPath(paths, "/api/v1/ead/{objectType}/{id}", "get", "Get object by id");
    addPath(paths, "/api/v1/ead/{objectType}/{id}", "put", "Update object by id");
    addPath(paths, "/api/v1/ead/{objectType}/{id}", "delete", "Delete object by id");
    spec["paths"] = paths;

    return spec;
}

void exportOpenApiSpec(string outputPath) {
    if (!outputPath.length) {
        return;
    }

    auto folder = dirName(outputPath);
    if (folder.length) {
        mkdirRecurse(folder);
    }

    auto rendered = serializeToJsonString(buildOpenApiSpec());
    write(outputPath, rendered);
}

private void addPath(ref Json paths, string pathKey, string method, string summary) {
    if ((pathKey in paths) is null) {
        paths[pathKey] = Json.emptyObject;
    }

    auto operation = Json.emptyObject;
    operation["summary"] = Json(summary);

    auto responses = Json.emptyObject;
    auto response200 = Json.emptyObject;
    response200["description"] = Json("Successful response");
    responses["200"] = response200;
    operation["responses"] = responses;

    auto securedMethods = ["get", "post", "put", "delete"];
    bool secured = false;
    foreach (m; securedMethods) {
        if (m == method && (pathKey != "/health" && pathKey != "/api/v1/health")) {
            secured = true;
            break;
        }
    }

    if (secured) {
        auto security = Json.emptyArray;
        auto bearer = Json.emptyObject;
        bearer["bearerAuth"] = Json.emptyArray;
        security ~= bearer;
        operation["security"] = security;
    }

    paths[pathKey][method] = operation;
}
