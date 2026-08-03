module uim.platform.bw.application.ports.query_runtime;

import vibe.data.json : Json;
import uim.platform.bw.application.dto : QueryExecutionDTO;

@safe:

interface BwQueryRuntime {
    Json execute(QueryExecutionDTO request);
}
