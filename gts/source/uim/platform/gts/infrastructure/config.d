module uim.platform.gts.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8136;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("GTS_HOST", "0.0.0.0");
    config.port = environment.get("GTS_PORT", "8136").to!ushort;
    return config;
}
