module uim.platform.maif.presentation.http.controllers.integration_flows;

import std.conv : to;
import uim.platform.maif;

@safe:

class IntegrationFlowController : SAPController {
    private ManageIntegrationFlowsUseCase useCase;

    this(ManageIntegrationFlowsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/maif/integration-flows", &handleList);
        router.get("/api/v1/maif/integration-flows/*", &handleGet);
        router.post("/api/v1/maif/integration-flows", &handleCreate);
        router.put("/api/v1/maif/integration-flows/*", &handleUpdate);
        router.delete_("/api/v1/maif/integration-flows/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= integrationFlowToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Integration flow not found");
            return;
        }
        res.writeJsonBody(integrationFlowToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        IntegrationFlowDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.appId = jsonStr(j, "appId");
        dto.name = jsonStr(j, "name");
        dto.sourceSystem = jsonStr(j, "sourceSystem");
        dto.targetSystem = jsonStr(j, "targetSystem");
        dto.protocol = jsonStr(j, "protocol");
        dto.mappingPolicy = jsonStr(j, "mappingPolicy");
        dto.retryPolicy = jsonStr(j, "retryPolicy");
        dto.status = jsonStr(j, "status");
        dto.createdBy = jsonStr(j, "createdBy");

        auto result = useCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 201);
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        IntegrationFlowDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.appId = jsonStr(j, "appId");
        dto.name = jsonStr(j, "name");
        dto.sourceSystem = jsonStr(j, "sourceSystem");
        dto.targetSystem = jsonStr(j, "targetSystem");
        dto.protocol = jsonStr(j, "protocol");
        dto.mappingPolicy = jsonStr(j, "mappingPolicy");
        dto.retryPolicy = jsonStr(j, "retryPolicy");
        dto.status = jsonStr(j, "status");
        dto.modifiedBy = jsonStr(j, "modifiedBy");

        auto result = useCase.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 200);
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        payload["message"] = Json("Integration flow deleted");
        res.writeJsonBody(payload, 200);
    }
}
