module uim.platform.ppm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8141;
    string persistenceEngine = "memory";
    string postgresUrl = "postgres://ppm:ppm@localhost:5432/ppm";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("PPM_HOST", "0.0.0.0");
    config.port = environment.get("PPM_PORT", "8141").to!ushort;
    config.persistenceEngine = environment.get("PPM_PERSISTENCE_ENGINE", "memory");
    config.postgresUrl = environment.get("PPM_POSTGRES_URL", "postgres://ppm:ppm@localhost:5432/ppm");
    return config;
}
