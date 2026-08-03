module uim.platform.bw.presentation.http.controllers.query_api;

import std.conv : to;
import uim.platform.bw;

@safe:

class QueryApiController : SAPController {
    private ManageBwObjectsUseCase manageUseCase;
    private QueryBwAssetsUseCase queryUseCase;

    this(ManageBwObjectsUseCase manageUseCase, QueryBwAssetsUseCase queryUseCase) {
        this.manageUseCase = manageUseCase;
        this.queryUseCase = queryUseCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/bw/search/models", &handleSearchModels);
        router.get("/api/v1/bw/data-flows/by-source/*", &handleListDataFlowsBySource);
        router.get("/api/v1/bw/queries/by-provider/*", &handleListQueriesByProvider);
        router.post("/api/v1/bw/query-executions", &handleQueryExecution);
        router.get("/api/v1/bw/api-catalog", &handleApiCatalog);
    }

    private void handleSearchModels(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto query = req.query.get("q", "");
        auto items = queryUseCase.search(query);
        writeCollection(res, items);
    }

    private void handleListDataFlowsBySource(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto sourceId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listDataFlowsBySource(sourceId);
        writeCollection(res, items);
    }

    private void handleListQueriesByProvider(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto providerId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listQueriesByProvider(providerId);
        writeCollection(res, items);
    }

    private void handleQueryExecution(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureWrite(req, res, "queries")) {
            return;
        }

        auto j = req.json;
        QueryExecutionDTO execution;
        execution.providerId = bwJsonStr(j, "providerId");
        execution.queryId = bwJsonStr(j, "queryId");
        execution.language = bwJsonStr(j, "language");
        execution.variables = bwJsonStringMap(j, "variables");

        auto payload = queryUseCase.executeQuery(execution);
        res.writeJsonBody(payload, 200);
    }

    private void handleApiCatalog(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto apis = manageUseCase.list(BwBusinessObjectType.apiDefinitions);
        writeCollection(res, apis);
    }

    private void writeCollection(scope HTTPServerResponse res, BwObject[] items) {
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= objectToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }
}
