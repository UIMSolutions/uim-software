module uim.platform.rpm.application.ports.analytics_runtime;

import vibe.data.json : Json;
import uim.platform.rpm.application.dto : KpiQueryDTO;

@safe:

interface RpmAnalyticsRuntime {
    Json summarize(KpiQueryDTO query);
}
