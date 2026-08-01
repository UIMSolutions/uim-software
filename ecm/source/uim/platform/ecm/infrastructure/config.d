module uim.platform.ecm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8190;
    string webRoot = "web";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("ECM_HOST", "0.0.0.0");
    config.port = environment.get("ECM_PORT", "8190").to!ushort;
    config.webRoot = environment.get("ECM_WEB_ROOT", "web");
    return config;
}
