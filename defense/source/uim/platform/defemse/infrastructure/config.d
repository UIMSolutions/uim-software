/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.defense.infrastructure.config;

import std.conv : to;
import std.process : environment;

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8130;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("defense_HOST", "0.0.0.0");
    config.port = environment.get("defense_PORT", "8130").to!ushort;
    return config;
}
