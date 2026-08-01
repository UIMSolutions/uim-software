module uim.platform.ecm.presentation.http.controllers.ui;

import std.file : exists, readText;
import std.path : buildPath;
import uim.platform.ecm;

@safe:

class UiController : SAPController {
    private string webRoot;

    this(string webRoot) {
        this.webRoot = webRoot;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/ui", &handleUi);
    }

    private void handleUi(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto pagePath = buildPath(webRoot, "index.html");
        if (!exists(pagePath)) {
            writeError(res, 404, "UI not found");
            return;
        }

        res.writeBody(readText(pagePath), 200, "text/html; charset=utf-8");
    }
}
