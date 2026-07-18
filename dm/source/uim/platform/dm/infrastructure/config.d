module uim.platform.dm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8138;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("DM_HOST", "0.0.0.0");
    config.port = environment.get("DM_PORT", "8138").to!ushort;
    return config;
}
