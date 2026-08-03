module uim.platform.material_traceability.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8590;
    string webRoot = "web";
    string repositoryEngine = "memory";
    string postgresUrl = "postgresql://localhost:5432/material_traceability";
    string mongoUrl = "mongodb://localhost:27017";
    string mongoDatabase = "material_traceability";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("MT_HOST", "0.0.0.0");
    config.port = environment.get("MT_PORT", "8590").to!ushort;
    config.webRoot = environment.get("MT_WEB_ROOT", "web");
    config.repositoryEngine = environment.get("MT_REPOSITORY", "memory");
    config.postgresUrl = environment.get("MT_POSTGRES_URL", "postgresql://localhost:5432/material_traceability");
    config.mongoUrl = environment.get("MT_MONGO_URL", "mongodb://localhost:27017");
    config.mongoDatabase = environment.get("MT_MONGO_DATABASE", "material_traceability");
    return config;
}
