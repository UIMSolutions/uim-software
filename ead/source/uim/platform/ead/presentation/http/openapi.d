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

    spec["components"] = buildComponents();

    auto paths = Json.emptyObject;
    addHealthPaths(paths);
    addRepositoryPaths(paths);
    addQueryPaths(paths);
    addOpenApiPath(paths);
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

private Json buildComponents() {
    auto components = Json.emptyObject;

    auto securitySchemes = Json.emptyObject;
    auto bearer = Json.emptyObject;
    bearer["type"] = Json("http");
    bearer["scheme"] = Json("bearer");
    securitySchemes["bearerAuth"] = bearer;
    components["securitySchemes"] = securitySchemes;

    auto schemas = Json.emptyObject;

    auto health = Json.emptyObject;
    health["type"] = Json("object");
    health["properties"] = Json.emptyObject;
    health["properties"]["status"] = schemaString();
    health["properties"]["service"] = schemaString();
    schemas["HealthResponse"] = health;

    auto eadObject = Json.emptyObject;
    eadObject["type"] = Json("object");
    eadObject["properties"] = Json.emptyObject;
    foreach (fieldName; [
        "id", "objectType", "tenantId", "technicalName", "businessName", "architectureLayer",
        "lifecycleState", "parentId", "sourceId", "targetId", "owner", "description",
        "externalReference", "createdBy", "modifiedBy", "createdAt", "modifiedAt"
    ]) {
        eadObject["properties"][fieldName] = schemaString();
    }
    eadObject["properties"]["metadata"] = schemaStringMap();
    schemas["EadObject"] = eadObject;

    auto eadObjectCollection = Json.emptyObject;
    eadObjectCollection["type"] = Json("object");
    eadObjectCollection["properties"] = Json.emptyObject;
    eadObjectCollection["properties"]["count"] = schemaInteger();
    eadObjectCollection["properties"]["resources"] = schemaArrayRef("EadObject");
    schemas["EadObjectCollection"] = eadObjectCollection;

    auto commandResult = Json.emptyObject;
    commandResult["type"] = Json("object");
    commandResult["properties"] = Json.emptyObject;
    commandResult["properties"]["id"] = schemaString();
    commandResult["properties"]["error"] = schemaString();
    schemas["CommandResult"] = commandResult;

    auto diagramRequest = Json.emptyObject;
    diagramRequest["type"] = Json("object");
    diagramRequest["properties"] = Json.emptyObject;
    diagramRequest["properties"]["diagramId"] = schemaString();
    diagramRequest["properties"]["viewpoint"] = schemaString();
    diagramRequest["properties"]["language"] = schemaString();
    diagramRequest["properties"]["variables"] = schemaStringMap();
    schemas["DiagramRenderRequest"] = diagramRequest;

    auto diagramResponse = Json.emptyObject;
    diagramResponse["type"] = Json("object");
    diagramResponse["additionalProperties"] = Json(true);
    schemas["DiagramRenderResponse"] = diagramResponse;

    auto openApiResponse = Json.emptyObject;
    openApiResponse["type"] = Json("object");
    openApiResponse["additionalProperties"] = Json(true);
    schemas["OpenApiDocument"] = openApiResponse;

    auto errorResponse = Json.emptyObject;
    errorResponse["type"] = Json("object");
    errorResponse["properties"] = Json.emptyObject;
    errorResponse["properties"]["error"] = schemaString();
    errorResponse["properties"]["status"] = schemaInteger();
    schemas["ErrorResponse"] = errorResponse;

    components["schemas"] = schemas;
    return components;
}

private void addHealthPaths(ref Json paths) {
    auto root = Json.emptyObject;
    root["get"] = basicOperation("Service root health", "HealthResponse", false);
    paths["/"] = root;

    auto health = Json.emptyObject;
    health["get"] = basicOperation("Service health", "HealthResponse", false);
    paths["/health"] = health;

    auto apiHealth = Json.emptyObject;
    apiHealth["get"] = basicOperation("Service health (API)", "HealthResponse", false);
    paths["/api/v1/health"] = apiHealth;
}

private void addRepositoryPaths(ref Json paths) {
    auto objectTypePath = Json.emptyObject;
    auto listOp = basicOperation("List objects for type", "EadObjectCollection", true);
    listOp["parameters"] = Json.emptyArray;
    listOp["parameters"] ~= pathParameter("objectType", "Architecture object type");
    objectTypePath["get"] = listOp;

    auto createOp = basicOperation("Create object for type", "CommandResult", true, "201");
    createOp["parameters"] = Json.emptyArray;
    createOp["parameters"] ~= pathParameter("objectType", "Architecture object type");
    createOp["requestBody"] = jsonRequestBody("EadObject", true);
    objectTypePath["post"] = createOp;
    paths["/api/v1/ead/{objectType}"] = objectTypePath;

    auto objectPath = Json.emptyObject;

    auto getOp = basicOperation("Get object by id", "EadObject", true);
    getOp["parameters"] = objectTypeAndIdParameters();
    objectPath["get"] = getOp;

    auto putOp = basicOperation("Update object by id", "CommandResult", true);
    putOp["parameters"] = objectTypeAndIdParameters();
    putOp["requestBody"] = jsonRequestBody("EadObject", true);
    objectPath["put"] = putOp;

    auto delOp = basicOperation("Delete object by id", "CommandResult", true);
    delOp["parameters"] = objectTypeAndIdParameters();
    objectPath["delete"] = delOp;

    paths["/api/v1/ead/{objectType}/{id}"] = objectPath;
}

private void addQueryPaths(ref Json paths) {
    auto searchPath = Json.emptyObject;
    auto searchOp = basicOperation("Search architecture models", "EadObjectCollection", true);
    searchOp["parameters"] = Json.emptyArray;
    searchOp["parameters"] ~= queryParameter("q", "Search query");
    searchPath["get"] = searchOp;
    paths["/api/v1/ead/search/models"] = searchPath;

    auto depPath = Json.emptyObject;
    auto depOp = basicOperation("List dependencies by source", "EadObjectCollection", true);
    depOp["parameters"] = Json.emptyArray;
    depOp["parameters"] ~= pathParameter("sourceId", "Source object id");
    depPath["get"] = depOp;
    paths["/api/v1/ead/dependencies/by-source/{sourceId}"] = depPath;

    auto impactPath = Json.emptyObject;
    auto impactOp = basicOperation("List impacts by target", "EadObjectCollection", true);
    impactOp["parameters"] = Json.emptyArray;
    impactOp["parameters"] ~= pathParameter("targetId", "Target object id");
    impactPath["get"] = impactOp;
    paths["/api/v1/ead/impacts/by-target/{targetId}"] = impactPath;

    auto layerPath = Json.emptyObject;
    auto layerOp = basicOperation("List viewpoints by architecture layer", "EadObjectCollection", true);
    layerOp["parameters"] = Json.emptyArray;
    layerOp["parameters"] ~= pathParameter("layer", "Architecture layer");
    layerPath["get"] = layerOp;
    paths["/api/v1/ead/viewpoints/by-layer/{layer}"] = layerPath;

    auto renderingPath = Json.emptyObject;
    auto renderingOp = basicOperation("Render architecture diagram", "DiagramRenderResponse", true);
    renderingOp["requestBody"] = jsonRequestBody("DiagramRenderRequest", true);
    renderingPath["post"] = renderingOp;
    paths["/api/v1/ead/diagram-renderings"] = renderingPath;

    auto catalogPath = Json.emptyObject;
    catalogPath["get"] = basicOperation("List API definitions from repository", "EadObjectCollection", true);
    paths["/api/v1/ead/api-catalog"] = catalogPath;
}

private void addOpenApiPath(ref Json paths) {
    auto openApiPath = Json.emptyObject;
    openApiPath["get"] = basicOperation("Get OpenAPI specification", "OpenApiDocument", true);
    paths["/api/v1/ead/openapi.json"] = openApiPath;
}

private Json basicOperation(string summary, string schemaName, bool secured, string successCode = "200") {
    auto operation = Json.emptyObject;
    operation["summary"] = Json(summary);

    auto responses = Json.emptyObject;
    responses[successCode] = responseWithSchema("Successful response", schemaName);
    responses["400"] = responseWithSchema("Bad request", "ErrorResponse");
    responses["401"] = responseWithSchema("Unauthorized", "ErrorResponse");
    responses["403"] = responseWithSchema("Forbidden", "ErrorResponse");
    responses["404"] = responseWithSchema("Not found", "ErrorResponse");
    operation["responses"] = responses;

    if (secured) {
        auto security = Json.emptyArray;
        auto bearer = Json.emptyObject;
        bearer["bearerAuth"] = Json.emptyArray;
        security ~= bearer;
        operation["security"] = security;
    }

    return operation;
}

private Json responseWithSchema(string description, string schemaName) {
    auto response = Json.emptyObject;
    response["description"] = Json(description);
    response["content"] = Json.emptyObject;
    response["content"]["application/json"] = Json.emptyObject;
    response["content"]["application/json"]["schema"] = schemaRef(schemaName);
    return response;
}

private Json jsonRequestBody(string schemaName, bool required) {
    auto body = Json.emptyObject;
    body["required"] = Json(required);
    body["content"] = Json.emptyObject;
    body["content"]["application/json"] = Json.emptyObject;
    body["content"]["application/json"]["schema"] = schemaRef(schemaName);
    return body;
}

private Json objectTypeAndIdParameters() {
    auto params = Json.emptyArray;
    params ~= pathParameter("objectType", "Architecture object type");
    params ~= pathParameter("id", "Object identifier");
    return params;
}

private Json pathParameter(string name, string description) {
    auto p = Json.emptyObject;
    p["name"] = Json(name);
    p["in"] = Json("path");
    p["required"] = Json(true);
    p["description"] = Json(description);
    p["schema"] = schemaString();
    return p;
}

private Json queryParameter(string name, string description) {
    auto p = Json.emptyObject;
    p["name"] = Json(name);
    p["in"] = Json("query");
    p["required"] = Json(false);
    p["description"] = Json(description);
    p["schema"] = schemaString();
    return p;
}

private Json schemaRef(string schemaName) {
    auto s = Json.emptyObject;
    s["$ref"] = Json("#/components/schemas/" ~ schemaName);
    return s;
}

private Json schemaString() {
    auto s = Json.emptyObject;
    s["type"] = Json("string");
    return s;
}

private Json schemaInteger() {
    auto s = Json.emptyObject;
    s["type"] = Json("integer");
    return s;
}

private Json schemaStringMap() {
    auto s = Json.emptyObject;
    s["type"] = Json("object");
    s["additionalProperties"] = schemaString();
    return s;
}

private Json schemaArrayRef(string schemaName) {
    auto s = Json.emptyObject;
    s["type"] = Json("array");
    s["items"] = schemaRef(schemaName);
    return s;
}

unittest {
    auto spec = buildOpenApiSpec();
    assert(("components" in spec) !is null);
    auto components = spec["components"].get!(Json[string]);
    assert(("schemas" in components) !is null);

    auto schemas = components["schemas"].get!(Json[string]);
    assert(("EadObject" in schemas) !is null);
    assert(("ErrorResponse" in schemas) !is null);
}
