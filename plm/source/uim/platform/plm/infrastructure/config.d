module uim.platform.plm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8131;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("PLM_HOST", "0.0.0.0");
    config.port = environment.get("PLM_PORT", "8131").to!ushort;
    return config;
}
