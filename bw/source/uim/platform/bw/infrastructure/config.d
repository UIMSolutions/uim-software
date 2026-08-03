module uim.platform.bw.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8290;
    string webRoot = "web";
    string repositoryEngine = "memory";
    string postgresUrl = "postgresql://localhost:5432/bw";
    string mongoUrl = "mongodb://localhost:27017";
    string mongoDatabase = "bw";
    string queryRuntimeUrl = "";
    string queryRuntimeBearerToken = "";
    uint queryRuntimeTimeoutSeconds = 15;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("BW_HOST", "0.0.0.0");
    config.port = environment.get("BW_PORT", "8290").to!ushort;
    config.webRoot = environment.get("BW_WEB_ROOT", "web");
    config.repositoryEngine = environment.get("BW_REPOSITORY", "memory");
    config.postgresUrl = environment.get("BW_POSTGRES_URL", "postgresql://localhost:5432/bw");
    config.mongoUrl = environment.get("BW_MONGO_URL", "mongodb://localhost:27017");
    config.mongoDatabase = environment.get("BW_MONGO_DATABASE", "bw");
    config.queryRuntimeUrl = environment.get("BW_QUERY_RUNTIME_URL", "");
    config.queryRuntimeBearerToken = environment.get("BW_QUERY_RUNTIME_BEARER_TOKEN", "");
    config.queryRuntimeTimeoutSeconds = environment.get("BW_QUERY_RUNTIME_TIMEOUT_SECONDS", "15").to!uint;
    return config;
}
