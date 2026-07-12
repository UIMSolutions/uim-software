module uim.platform.etd.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8168;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("ETD_HOST", "0.0.0.0");
    config.port = environment.get("ETD_PORT", "8168").to!ushort;
    return config;
}
