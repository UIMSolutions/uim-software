module uim.platform.rpm.presentation.http.controllers.operations_api;

import std.conv : to;
import uim.platform.rpm;

@safe:

class OperationsApiController : SAPController {
    private QueryRpmNetworkUseCase queryUseCase;
    private ManageOperationsUseCase operationsUseCase;

    this(QueryRpmNetworkUseCase queryUseCase, ManageOperationsUseCase operationsUseCase) {
        this.queryUseCase = queryUseCase;
        this.operationsUseCase = operationsUseCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/rpm/search/models", &handleSearchModels);
        router.post("/api/v1/rpm/operations", &handleOperation);
        router.get("/api/v1/rpm/trace/*", &handleTraceAsset);
        router.get("/api/v1/rpm/pool-balances/*", &handlePoolBalances);
        router.get("/api/v1/rpm/kpis", &handleKpis);
    }

    private void handleSearchModels(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto q = req.query.get("q", "");
        auto items = queryUseCase.search(q);
        writeCollection(res, items);
    }

    private void handleOperation(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureWrite(req, res, "operations")) {
            return;
        }

        auto j = req.json;
        OperationRequestDTO request;
        request.operationType = rpmJsonStr(j, "operationType");
        request.poolId = rpmJsonStr(j, "poolId");
        request.packagingMaterialId = rpmJsonStr(j, "packagingMaterialId");
        request.assetId = rpmJsonStr(j, "assetId");
        request.fromLocationId = rpmJsonStr(j, "fromLocationId");
        request.toLocationId = rpmJsonStr(j, "toLocationId");
        request.partnerId = rpmJsonStr(j, "partnerId");
        request.quantity = rpmJsonLong(j, "quantity");
        request.referenceId = rpmJsonStr(j, "referenceId");
        request.executedBy = rpmJsonStr(j, "executedBy");
        request.notes = rpmJsonStr(j, "notes");

        auto result = operationsUseCase.execute(request);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 201);
    }

    private void handleTraceAsset(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto assetId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.traceAsset(assetId);
        writeCollection(res, items);
    }

    private void handlePoolBalances(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto poolId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listPoolBalances(poolId);
        writeCollection(res, items);
    }

    private void handleKpis(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        KpiQueryDTO query;
        query.fromDate = req.query.get("from", "");
        query.toDate = req.query.get("to", "");
        query.tenantId = req.headers.get("X-Tenant-Id", "default");

        auto payload = queryUseCase.kpis(query);
        res.writeJsonBody(payload, 200);
    }

    private void writeCollection(scope HTTPServerResponse res, RpmObject[] items) {
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
