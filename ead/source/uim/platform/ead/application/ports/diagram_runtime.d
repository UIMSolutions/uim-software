module uim.platform.ead.application.ports.diagram_runtime;

import vibe.data.json : Json;
import uim.platform.ead.application.dto : DiagramRenderRequestDTO;

@safe:

interface DiagramRuntime {
    Json render(DiagramRenderRequestDTO request);
}
