module uim.platform.apm.presentation.http.controllers.portfolio_analysis;

import uim.platform.apm;

@safe:

class PortfolioAnalysisController : SAPController {
    private AnalyzePortfolioUseCase useCase;

    this(AnalyzePortfolioUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/apm/portfolio/summary", &handleSummary);
        router.get("/api/v1/apm/portfolio/matrix", &handleMatrix);
    }

    private void handleSummary(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto tenantId = req.headers.get("X-Tenant-Id", "");
        auto summary = useCase.summary(tenantId);
        writeJsonBody(res, summaryToJson(summary));
    }

    private void handleMatrix(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto tenantId = req.headers.get("X-Tenant-Id", "");
        auto points = useCase.matrix(tenantId);
        auto arr = Json.emptyArray;
        foreach (point; points) arr ~= matrixPointToJson(point);
        writeJsonBody(res, Json(["count": Json(cast(long) points.length), "resources": arr]));
    }
}
