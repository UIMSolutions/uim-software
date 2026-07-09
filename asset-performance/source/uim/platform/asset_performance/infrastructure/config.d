/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.software.asset_performance.infrastructure.config;

import uim.software.asset_performance;

mixin(ShowModule!());

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8105;
    bool seedOnStart = false;
}

AppConfig loadConfig() {
    import std.process : environment;
    import std.conv : to;
    import std.string : toLower;

    AppConfig config;
    auto host = environment.get("ASSET_PERFORMANCE_HOST", "0.0.0.0");
    auto port = environment.get("ASSET_PERFORMANCE_PORT", "8105");
    auto seedOnStart = environment.get("ASSET_PERFORMANCE_SEED_ON_START", "false").toLower();
    config.host = host;
    config.port = port.to!ushort;
    config.seedOnStart = seedOnStart == "true" || seedOnStart == "1" || seedOnStart == "yes";
    return config;
}
