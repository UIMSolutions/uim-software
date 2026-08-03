module uim.platform.ead.presentation.http.controllers.query_api;

import uim.platform.ead;

@safe:

class QueryApiController : SAPController {
    private ManageEadObjectsUseCase manageUseCase;
    private QueryEadAssetsUseCase queryUseCase;

    this(ManageEadObjectsUseCase manageUseCase, QueryEadAssetsUseCase queryUseCase) {
        this.manageUseCase = manageUseCase;
        this.queryUseCase = queryUseCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ead/search/models", &handleSearchModels);
        router.get("/api/v1/ead/dependencies/by-source/*", &handleListDependenciesBySource);
        router.get("/api/v1/ead/impacts/by-target/*", &handleListImpactsByTarget);
        router.get("/api/v1/ead/viewpoints/by-layer/*", &handleListViewpointsByLayer);
        router.post("/api/v1/ead/diagram-renderings", &handleDiagramRendering);
        router.get("/api/v1/ead/api-catalog", &handleApiCatalog);
        router.get("/api/v1/ead/openapi.json", &handleOpenApi);
    }

    private void handleSearchModels(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto query = req.query.get("q", "");
        auto items = queryUseCase.search(query);
        writeCollection(res, items);
    }

    private void handleListDependenciesBySource(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto sourceId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listDependenciesBySource(sourceId);
        writeCollection(res, items);
    }

    private void handleListImpactsByTarget(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto targetId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listImpactsByTarget(targetId);
        writeCollection(res, items);
    }

    private void handleListViewpointsByLayer(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto layer = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listViewpointsByLayer(layer);
        writeCollection(res, items);
    }

    private void handleDiagramRendering(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureWrite(req, res, "diagrams")) {
            return;
        }

        auto j = req.json;
        DiagramRenderRequestDTO request;
        request.diagramId = eadJsonStr(j, "diagramId");
        request.viewpoint = eadJsonStr(j, "viewpoint");
        request.language = eadJsonStr(j, "language");
        request.variables = eadJsonStringMap(j, "variables");

        auto payload = queryUseCase.renderDiagram(request);
        res.writeJsonBody(payload, 200);
    }

    private void handleApiCatalog(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto apis = manageUseCase.list(EadBusinessObjectType.apiDefinitions);
        writeCollection(res, apis);
    }

    private void handleOpenApi(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        res.writeJsonBody(buildOpenApiSpec(), 200);
    }

    private void writeCollection(scope HTTPServerResponse res, EadObject[] items) {
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
