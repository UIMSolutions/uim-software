module uim.platform.rpm.infrastructure.runtime.simulated_analytics;

import vibe.data.json : Json;
import uim.platform.rpm.application.dto : KpiQueryDTO;
import uim.platform.rpm.application.ports.analytics_runtime : RpmAnalyticsRuntime;

@safe:

class SimulatedRpmAnalyticsRuntime : RpmAnalyticsRuntime {
    override Json summarize(KpiQueryDTO query) {
        auto payload = Json.emptyObject;
        payload["fromDate"] = Json(query.fromDate.length ? query.fromDate : "2026-01-01");
        payload["toDate"] = Json(query.toDate.length ? query.toDate : "2026-12-31");
        payload["tenantId"] = Json(query.tenantId.length ? query.tenantId : "default");

        auto metrics = Json.emptyArray;

        auto m1 = Json.emptyObject;
        m1["name"] = Json("cycleTimeDays");
        m1["value"] = Json("9.2");
        metrics ~= m1;

        auto m2 = Json.emptyObject;
        m2["name"] = Json("assetUtilizationPercent");
        m2["value"] = Json("84.6");
        metrics ~= m2;

        auto m3 = Json.emptyObject;
        m3["name"] = Json("lossRatePercent");
        m3["value"] = Json("1.1");
        metrics ~= m3;

        auto m4 = Json.emptyObject;
        m4["name"] = Json("onTimeReturnPercent");
        m4["value"] = Json("92.4");
        metrics ~= m4;

        payload["metrics"] = metrics;

        auto meta = Json.emptyObject;
        meta["mode"] = Json("simulated");
        meta["message"] = Json("KPIs were computed by the built-in simulator.");
        payload["meta"] = meta;

        return payload;
    }
}
