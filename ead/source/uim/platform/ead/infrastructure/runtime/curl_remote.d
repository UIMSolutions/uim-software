module uim.platform.ead.infrastructure.runtime.curl_remote;

import std.conv : to;
import std.process : executeProcess = execute;
import std.string : strip;
import vibe.data.json : Json, parseJsonString, serializeToJsonString;
import uim.platform.ead.application.dto : DiagramRenderRequestDTO;
import uim.platform.ead.application.ports.diagram_runtime : DiagramRuntime;

@safe:

class CurlRemoteDiagramRuntime : DiagramRuntime {
    private string endpointUrl;
    private string bearerToken;
    private uint timeoutSeconds;

    this(string endpointUrl, string bearerToken, uint timeoutSeconds = 15) {
        this.endpointUrl = endpointUrl;
        this.bearerToken = bearerToken;
        this.timeoutSeconds = timeoutSeconds > 0 ? timeoutSeconds : 15;
    }

    override Json render(DiagramRenderRequestDTO request) {
        auto requestJson = toJson(request);
        auto requestBody = serializeToJsonString(requestJson);

        string[] args = [
            "curl", "-sS", "-X", "POST",
            "--max-time", timeoutSeconds.to!string,
            "-H", "Content-Type: application/json",
            "-H", "Accept: application/json"
        ];
        if (bearerToken.length) {
            args ~= ["-H", "Authorization: Bearer " ~ bearerToken];
        }
        args ~= ["-d", requestBody, endpointUrl];

        auto result = executeCurl(args);
        if (result.status == 0 && result.output.strip.length) {
            try {
                auto parsed = parseJsonString(result.output);
                auto payload = Json.emptyObject;
                payload["request"] = requestJson;
                payload["response"] = parsed;
                auto meta = Json.emptyObject;
                meta["executionMode"] = Json("remote");
                meta["backend"] = Json(endpointUrl);
                payload["meta"] = meta;
                return payload;
            } catch (Exception ex) {
            }
        }

        auto fallback = Json.emptyObject;
        fallback["request"] = requestJson;
        fallback["response"] = Json.emptyObject;
        fallback["statusCode"] = Json(result.status);
        fallback["raw"] = Json(result.output);

        auto meta = Json.emptyObject;
        meta["executionMode"] = Json("remote-error");
        meta["backend"] = Json(endpointUrl);
        meta["message"] = Json("Remote diagram runtime call failed or returned non-JSON.");
        fallback["meta"] = meta;

        return fallback;
    }

    private Json toJson(DiagramRenderRequestDTO request) {
        auto payload = Json.emptyObject;
        payload["diagramId"] = Json(request.diagramId);
        payload["viewpoint"] = Json(request.viewpoint);
        payload["language"] = Json(request.language.length ? request.language : "EN");

        auto variables = Json.emptyObject;
        foreach (k, v; request.variables) {
            variables[k] = Json(v);
        }
        payload["variables"] = variables;
        return payload;
    }

    private auto executeCurl(string[] args) @trusted {
        return executeProcess(args);
    }
}
