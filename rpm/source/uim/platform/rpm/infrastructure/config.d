module uim.platform.rpm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8390;
    string webRoot = "web";
    string repositoryEngine = "memory";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("RPM_HOST", "0.0.0.0");
    config.port = environment.get("RPM_PORT", "8390").to!ushort;
    config.webRoot = environment.get("RPM_WEB_ROOT", "web");
    config.repositoryEngine = environment.get("RPM_REPOSITORY", "memory");
    return config;
}
