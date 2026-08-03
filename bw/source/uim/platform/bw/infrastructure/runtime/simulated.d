module uim.platform.bw.infrastructure.runtime.simulated;

import vibe.data.json : Json;
import uim.platform.bw.application.dto : QueryExecutionDTO;
import uim.platform.bw.application.ports.query_runtime : BwQueryRuntime;

@safe:

class SimulatedBwQueryRuntime : BwQueryRuntime {
    override Json execute(QueryExecutionDTO request) {
        auto payload = Json.emptyObject;
        payload["providerId"] = Json(request.providerId);
        payload["queryId"] = Json(request.queryId);
        payload["language"] = Json(request.language.length ? request.language : "EN");

        auto variables = Json.emptyObject;
        foreach (k, v; request.variables) {
            variables[k] = Json(v);
        }
        payload["variables"] = variables;

        auto rows = Json.emptyArray;

        auto row1 = Json.emptyObject;
        row1["KPI"] = Json("NetSales");
        row1["VALUE"] = Json("1250000");
        row1["CURRENCY"] = Json("EUR");
        rows ~= row1;

        auto row2 = Json.emptyObject;
        row2["KPI"] = Json("GrossMargin");
        row2["VALUE"] = Json("37.4");
        row2["UNIT"] = Json("PERCENT");
        rows ~= row2;

        payload["rows"] = rows;

        auto meta = Json.emptyObject;
        meta["executionMode"] = Json("simulated");
        meta["message"] = Json("No remote BW runtime configured. Returned deterministic mock results.");
        payload["meta"] = meta;

        return payload;
    }
}
