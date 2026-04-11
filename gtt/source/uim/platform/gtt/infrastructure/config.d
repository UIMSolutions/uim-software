/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.config;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8115;
}

AppConfig loadConfig() {
    import std.process : environment;
    import std.conv : to;

    AppConfig config;
    auto host = environment.get("GTT_HOST", "0.0.0.0");
    auto port = environment.get("GTT_PORT", "8115");
    config.host = host;
    config.port = port.to!ushort;
    return config;
}
