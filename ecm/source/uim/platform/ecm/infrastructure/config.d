module uim.platform.ecm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8190;
    string webRoot = "web";
    string repositoryEngine = "memory";
    string postgresUrl = "postgresql://localhost:5432/ecm";
    string mongoUrl = "mongodb://localhost:27017";
    string mongoDatabase = "ecm";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("ECM_HOST", "0.0.0.0");
    config.port = environment.get("ECM_PORT", "8190").to!ushort;
    config.webRoot = environment.get("ECM_WEB_ROOT", "web");
    config.repositoryEngine = environment.get("ECM_REPOSITORY", "memory");
    config.postgresUrl = environment.get("ECM_POSTGRES_URL", "postgresql://localhost:5432/ecm");
    config.mongoUrl = environment.get("ECM_MONGO_URL", "mongodb://localhost:27017");
    config.mongoDatabase = environment.get("ECM_MONGO_DATABASE", "ecm");
    return config;
}
