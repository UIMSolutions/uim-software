module uim.platform.mm.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8150;
    string storage = "memory";
    string storagePath = ".data/mm";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("MM_HOST", "0.0.0.0");
    config.port = environment.get("MM_PORT", "8150").to!ushort;
    config.storage = environment.get("MM_STORAGE", "memory");
    config.storagePath = environment.get("MM_STORAGE_PATH", ".data/mm");
    return config;
}