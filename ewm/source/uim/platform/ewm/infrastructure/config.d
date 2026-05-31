module uim.platform.ewm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8132;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("EWM_HOST", "0.0.0.0");
    config.port = environment.get("EWM_PORT", "8132").to!ushort;
    return config;
}
