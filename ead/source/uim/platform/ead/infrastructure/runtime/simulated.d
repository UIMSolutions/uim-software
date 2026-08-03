module uim.platform.ead.infrastructure.runtime.simulated;

import vibe.data.json : Json;
import uim.platform.ead.application.dto : DiagramRenderRequestDTO;
import uim.platform.ead.application.ports.diagram_runtime : DiagramRuntime;

@safe:

class SimulatedDiagramRuntime : DiagramRuntime {
    override Json render(DiagramRenderRequestDTO request) {
        auto payload = Json.emptyObject;
        payload["diagramId"] = Json(request.diagramId);
        payload["viewpoint"] = Json(request.viewpoint.length ? request.viewpoint : "landscape");
        payload["language"] = Json(request.language.length ? request.language : "EN");

        auto variables = Json.emptyObject;
        foreach (k, v; request.variables) {
            variables[k] = Json(v);
        }
        payload["variables"] = variables;

        auto nodes = Json.emptyArray;
        auto n1 = Json.emptyObject;
        n1["id"] = Json("APP_S4");
        n1["type"] = Json("application-component");
        nodes ~= n1;

        auto n2 = Json.emptyObject;
        n2["id"] = Json("APP_BTP");
        n2["type"] = Json("application-component");
        nodes ~= n2;

        auto edges = Json.emptyArray;
        auto e1 = Json.emptyObject;
        e1["id"] = Json("DEP_001");
        e1["source"] = Json("APP_S4");
        e1["target"] = Json("APP_BTP");
        edges ~= e1;

        payload["nodes"] = nodes;
        payload["edges"] = edges;

        auto meta = Json.emptyObject;
        meta["executionMode"] = Json("simulated");
        meta["message"] = Json("No remote render runtime configured. Returned deterministic model graph.");
        payload["meta"] = meta;

        return payload;
    }
}
