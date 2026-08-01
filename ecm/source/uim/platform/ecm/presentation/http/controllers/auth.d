module uim.platform.ecm.presentation.http.controllers.auth;

import std.algorithm.searching : canFind;
import std.string : split, strip, toLower;
import uim.platform.ecm;

@safe:

private string[] parseRoles(string raw) {
    string[] roles;
    foreach (part; raw.split(",")) {
        auto role = part.strip.toLower();
        if (role.length > 0) {
            roles ~= role;
        }
    }
    return roles;
}

private bool hasAnyRole(string[] actual, string[] required) {
    foreach (role; required) {
        if (actual.canFind(role.toLower)) {
            return true;
        }
    }
    return false;
}

bool ensureAuthenticated(scope HTTPServerRequest req, scope HTTPServerResponse res) {
    auto auth = req.headers.get("Authorization", "");
    if (auth.length < 8 || auth[0 .. 7] != "Bearer ") {
        writeError(res, 401, "Unauthorized: Bearer token required");
        return false;
    }
    return true;
}

bool ensureReadAccess(scope HTTPServerRequest req, scope HTTPServerResponse res) {
    return ensureAuthenticated(req, res);
}

bool ensureWriteAccess(scope HTTPServerRequest req, scope HTTPServerResponse res, string objectType) {
    if (!ensureAuthenticated(req, res)) {
        return false;
    }

    auto roles = parseRoles(req.headers.get("X-ECM-Roles", ""));
    auto required = ["ecm.admin", "ecm.write", objectType.toLower ~ ".write"];
    if (!hasAnyRole(roles, required)) {
        writeError(res, 403, "Forbidden: missing write role");
        return false;
    }

    return true;
}

unittest {
    string[] roles = ["ecm.read", "documents.write", "ecm.audit"];
    assert(hasAnyRole(roles, ["documents.write"]));
    assert(!hasAnyRole(roles, ["ecm.admin"]));
}
