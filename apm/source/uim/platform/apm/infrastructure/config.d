module uim.platform.apm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8140;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("APM_HOST", "0.0.0.0");
    config.port = environment.get("APM_PORT", "8140").to!ushort;
    return config;
}
