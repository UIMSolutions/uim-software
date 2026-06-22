module uim.platform.team.presentation.http.controllers.plm_analysis;

import uim.platform.team;

@safe:

class PlmAnalysisController : SAPController {
    private AnalyzePlmUseCase useCase;

    this(AnalyzePlmUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/team/plm/summary", &handleSummary);
        router.get("/api/v1/team/plm/change-impact", &handleChangeImpact);
    }

    private void handleSummary(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto data = useCase.summary(req.headers.get("X-Tenant-Id", ""));
        writeJsonBody(res, plmSummaryToJson(data));
    }

    private void handleChangeImpact(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.changeImpact(req.headers.get("X-Tenant-Id", ""));
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= changeImpactToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }
}
