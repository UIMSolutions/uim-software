module uim.platform.mm.presentation.http.controllers.web_client;

import uim.platform.mm;

@safe:

class MmWebClientController : SAPController {
    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/client", &handleClient);
    }

    private void handleClient(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        enum html = import("uim/platform/mm/presentation/http/controllers/client.html");
        res.writeBody(html, 200, "text/html; charset=utf-8");
    }
}