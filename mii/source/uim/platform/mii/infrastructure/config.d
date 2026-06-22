module uim.platform.mii.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8132;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("MII_HOST", "0.0.0.0");
    config.port = environment.get("MII_PORT", "8132").to!ushort;
    return config;
}
