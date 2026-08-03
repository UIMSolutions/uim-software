module uim.platform.ead.infrastructure.config;

import std.conv : to;
import std.process : environment;
import std.string : strip, toLower;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8275;
    string webRoot = "web";
    string repositoryEngine = "memory";
    string postgresUrl = "postgresql://localhost:5432/ead";
    string mongoUrl = "mongodb://localhost:27017";
    string mongoDatabase = "ead";
    string diagramRuntimeUrl = "";
    string diagramRuntimeBearerToken = "";
    uint diagramRuntimeTimeoutSeconds = 15;
    bool seedEnabled = true;
    string openApiExportPath = "docs/openapi.json";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("EAD_HOST", "0.0.0.0");
    config.port = environment.get("EAD_PORT", "8275").to!ushort;
    config.webRoot = environment.get("EAD_WEB_ROOT", "web");
    config.repositoryEngine = environment.get("EAD_REPOSITORY", "memory");
    config.postgresUrl = environment.get("EAD_POSTGRES_URL", "postgresql://localhost:5432/ead");
    config.mongoUrl = environment.get("EAD_MONGO_URL", "mongodb://localhost:27017");
    config.mongoDatabase = environment.get("EAD_MONGO_DATABASE", "ead");
    config.diagramRuntimeUrl = environment.get("EAD_DIAGRAM_RUNTIME_URL", "");
    config.diagramRuntimeBearerToken = environment.get("EAD_DIAGRAM_RUNTIME_BEARER_TOKEN", "");
    config.diagramRuntimeTimeoutSeconds = environment.get("EAD_DIAGRAM_RUNTIME_TIMEOUT_SECONDS", "15").to!uint;
    config.seedEnabled = envBool("EAD_SEED_ENABLED", true);
    config.openApiExportPath = environment.get("EAD_OPENAPI_EXPORT_PATH", "docs/openapi.json");
    return config;
}

private bool envBool(string key, bool defaultValue) {
    auto raw = environment.get(key, defaultValue ? "true" : "false").strip.toLower();
    if (raw == "1" || raw == "true" || raw == "yes" || raw == "on") {
        return true;
    }
    if (raw == "0" || raw == "false" || raw == "no" || raw == "off") {
        return false;
    }
    return defaultValue;
}
