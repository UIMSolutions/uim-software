/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.infrastructure.config;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8125;
}

AppConfig loadConfig() {
    import std.process : environment;
    import std.conv : to;

    AppConfig config;
    auto host = environment.get("SIEM_HOST", "0.0.0.0");
    auto port = environment.get("SIEM_PORT", "8125");
    config.host = host;
    config.port = port.to!ushort;
    return config;
}
