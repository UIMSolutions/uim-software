module uim.platform.mm.infrastructure.config;

import std.conv : to;
import std.process : environment;

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8150;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("MM_HOST", "0.0.0.0");
    config.port = environment.get("MM_PORT", "8150").to!ushort;
    return config;
}