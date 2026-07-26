module uim.platform.alm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8160;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("ALM_HOST", "0.0.0.0");
    config.port = environment.get("ALM_PORT", "8160").to!ushort;
    return config;
}
