module uim.platform.mrp.infrastructure.config;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8119;
}

AppConfig loadConfig() {
    import std.process : environment;
    import std.conv : to;

    AppConfig config;
    config.host = environment.get("MRP_HOST", "0.0.0.0");
    config.port = environment.get("MRP_PORT", "8119").to!ushort;
    return config;
}
