module uim.platform.lean.presentation.web.views;

import std.string : replace;
import vibe.data.json : serializeToJsonString;

@safe:

struct WebInterfaceDefinition {
    string key;
    string title;
    string apiPath;
    string[] createFields;
    string[] updateFields;
}

WebInterfaceDefinition[] defaultWebInterfaceDefinitions() {
    return [
    WebInterfaceDefinition(
      "objectives",
      "Objectives",
      "/api/v1/lean/objectives",
      ["name", "description", "objectiveType", "targetDate", "owner", "owningOrgId", "createdBy"],
      ["name", "description", "targetDate", "owner", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "platforms",
      "Platforms",
      "/api/v1/lean/platforms",
      ["name", "description", "owner", "owningOrgId", "createdBy"],
      ["name", "description", "owner", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "initiatives",
      "Initiatives",
      "/api/v1/lean/initiatives",
      [
        "name", "description", "initiativeStatus", "phase", "budgetUsd",
        "startDate", "endDate", "responsiblePerson", "responsibleOrgId", "createdBy"
      ],
      ["name", "description", "budgetUsd", "endDate", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "organizations",
      "Organizations",
      "/api/v1/lean/organizations",
      [
        "name", "description", "parentOrgId", "orgCode", "costCenter",
        "headCount", "location", "orgHead", "createdBy"
      ],
      ["name", "description", "orgHead", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "business-capabilities",
      "Business Capabilities",
      "/api/v1/lean/business-capabilities",
      ["name", "description", "parentCapabilityId", "maturityLevel", "owningOrgId", "createdBy"],
      ["name", "description", "maturityLevel", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "business-contexts",
      "Business Contexts",
      "/api/v1/lean/business-contexts",
      ["name", "description", "capabilityId", "owningOrgId", "processOwner", "frequency", "createdBy"],
      ["name", "description", "processOwner", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "data-objects",
      "Data Objects",
      "/api/v1/lean/data-objects",
      [
        "name", "description", "classification", "owningApplicationId", "dataFormat",
        "retentionPeriodDays", "personalDataFlag", "gdprBasis", "createdBy"
      ],
      ["name", "description", "classification", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "applications",
      "Applications",
      "/api/v1/lean/applications",
      [
        "name", "description", "applicationType", "lifecycleStatus", "functionalFit",
        "technicalFit", "owningOrgId", "itOwner", "businessOwner", "vendor",
        "annualCostUsd", "createdBy"
      ],
      ["name", "description", "lifecycleStatus", "functionalFit", "technicalFit", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "interfaces",
      "App Interfaces",
      "/api/v1/lean/interfaces",
      [
        "name", "description", "sourceApplicationId", "targetApplicationId", "direction",
        "frequency", "protocol", "dataFormat", "dataObjectId", "createdBy"
      ],
      ["name", "description", "protocol", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "providers",
      "Providers",
      "/api/v1/lean/providers",
      [
        "name", "description", "website", "contactEmail", "contractNumber",
        "contractStartDate", "contractEndDate", "annualCostUsd", "country", "createdBy"
      ],
      ["name", "description", "contactEmail", "annualCostUsd", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "it-components",
      "IT Components",
      "/api/v1/lean/it-components",
      [
        "name", "description", "componentType", "lifecycleStatus", "techCategoryId",
        "providerId", "releaseDate", "endOfLifeDate", "licenseModel", "annualCostUsd",
        "technicalRisk", "createdBy"
      ],
      ["name", "description", "lifecycleStatus", "technicalRisk", "modifiedBy"]
    ),
    WebInterfaceDefinition(
      "tech-categories",
      "Tech Categories",
      "/api/v1/lean/tech-categories",
      ["name", "description", "parentCategoryId", "createdBy"],
      ["name", "description", "modifiedBy"]
    )
    ];
}

string renderLeanWebIndex(WebInterfaceDefinition[] defs) {
    string cards;
    foreach (def; defs) {
    cards ~= "<a class=\"card\" href=\"/web/lean/" ~ def.key ~ "\">"
      ~ "<h3>" ~ def.title ~ "</h3>"
      ~ "<p>" ~ def.apiPath ~ "</p></a>";
    }

    auto html = q"HTML
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>LEAN MVC Interfaces</title>
<style>
:root {
  --ink: #14213d;
  --brand: #0a9396;
  --accent: #ee9b00;
  --paper: #f8f7f4;
  --card: #ffffff;
}
body {
  margin: 0;
  font-family: "IBM Plex Sans", "Segoe UI", sans-serif;
  color: var(--ink);
  background: radial-gradient(circle at 10% 10%, #d8f3dc, transparent 35%),
              radial-gradient(circle at 90% 0%, #ffe6a7, transparent 28%),
              var(--paper);
}
header {
  padding: 2rem 1rem 1rem 1rem;
  text-align: center;
}
h1 { margin: 0; font-size: 2rem; }
main {
  max-width: 1100px;
  margin: 0 auto;
  padding: 1rem;
}
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 0.9rem;
}
.card {
  text-decoration: none;
  color: var(--ink);
  background: var(--card);
  border: 1px solid #d8e2dc;
  border-radius: 12px;
  padding: 1rem;
  box-shadow: 0 8px 16px rgba(20, 33, 61, 0.08);
  transition: transform .15s ease, box-shadow .15s ease;
}
.card:hover {
  transform: translateY(-2px);
  box-shadow: 0 14px 20px rgba(20, 33, 61, 0.13);
}
.card h3 { margin: 0 0 .5rem 0; color: var(--brand); }
.card p { margin: 0; font-size: .9rem; word-break: break-word; }
</style>
</head>
<body>
<header>
  <h1>LEAN MVC Web Interfaces</h1>
  <p>One web interface per use case, backed by the existing REST controllers.</p>
</header>
<main>
  <div class="grid">
    __CARDS__
  </div>
</main>
</body>
</html>
HTML";

    return html.replace("__CARDS__", cards);
}

string renderLeanCrudPage(WebInterfaceDefinition def) {
    auto html = q"HTML
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>__TITLE__ - LEAN MVC Interface</title>
<style>
:root {
  --ink: #1b263b;
  --brand: #0f766e;
  --accent: #ca6702;
  --paper: #fefae0;
  --card: #ffffff;
}
body {
  margin: 0;
  font-family: "IBM Plex Sans", "Segoe UI", sans-serif;
  color: var(--ink);
  background: linear-gradient(180deg, #fefae0 0%, #edf6f9 70%);
}
header, main {
  max-width: 1080px;
  margin: 0 auto;
  padding: 1rem;
}
header h1 { margin-bottom: 0.2rem; }
header a { color: var(--brand); text-decoration: none; }
.layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}
@media (max-width: 880px) {
  .layout { grid-template-columns: 1fr; }
}
.panel {
  background: var(--card);
  border: 1px solid #dfe7e2;
  border-radius: 12px;
  padding: 1rem;
}
label {
  display: block;
  margin-top: .6rem;
  margin-bottom: .2rem;
  font-weight: 600;
}
input {
  width: 100%;
  padding: .55rem;
  border: 1px solid #c6d3cf;
  border-radius: 8px;
}
button {
  margin-top: .8rem;
  margin-right: .4rem;
  border: none;
  border-radius: 8px;
  padding: .55rem .9rem;
  cursor: pointer;
  color: white;
  background: var(--brand);
  font-weight: 700;
}
button.warn { background: #bb3e03; }
pre {
  background: #0d1b2a;
  color: #e0e1dd;
  min-height: 340px;
  max-height: 65vh;
  overflow: auto;
  border-radius: 8px;
  padding: .8rem;
}
</style>
</head>
<body>
<header>
  <h1>__TITLE__</h1>
  <a href="/web/lean">Back to all use cases</a>
  <p>Model: __API__</p>
</header>
<main class="layout">
  <section class="panel">
    <label for="tenant">Tenant ID (X-Tenant-Id)</label>
    <input id="tenant" value="TEN-1" />
    <label for="rid">Resource ID</label>
    <input id="rid" placeholder="id" />
    <div id="createFields"></div>
    <div id="updateFields"></div>
    <button id="listBtn">List</button>
    <button id="getBtn">Get By ID</button>
    <button id="createBtn">Create</button>
    <button id="updateBtn">Update</button>
    <button id="deleteBtn" class="warn">Delete</button>
  </section>
  <section class="panel">
    <pre id="out">Ready</pre>
  </section>
</main>
<script>
const API = "__API__";
const CREATE_FIELDS = __CREATE_FIELDS__;
const UPDATE_FIELDS = __UPDATE_FIELDS__;
const out = document.getElementById("out");

function fieldMarkup(prefix, field) {
  return `<label for="${prefix}_${field}">${field}</label><input id="${prefix}_${field}" placeholder="${field}" />`;
}

function initFields() {
  const createTarget = document.getElementById("createFields");
  const updateTarget = document.getElementById("updateFields");
  createTarget.innerHTML = "<h3>Create Payload</h3>" + CREATE_FIELDS.map(f => fieldMarkup("c", f)).join("");
  updateTarget.innerHTML = "<h3>Update Payload</h3>" + UPDATE_FIELDS.map(f => fieldMarkup("u", f)).join("");
}

function pick(prefix, fields) {
  const payload = {};
  for (const field of fields) {
    const value = document.getElementById(`${prefix}_${field}`).value;
    if (value.length > 0) payload[field] = value;
  }
  return payload;
}

async function callApi(url, opts) {
  const resp = await fetch(url, opts);
  const text = await resp.text();
  try {
    out.textContent = JSON.stringify(JSON.parse(text), null, 2);
  } catch (e) {
    out.textContent = text;
  }
}

document.getElementById("listBtn").addEventListener("click", async () => {
  await callApi(API, { method: "GET" });
});

document.getElementById("getBtn").addEventListener("click", async () => {
  const id = document.getElementById("rid").value;
  await callApi(`${API}/${encodeURIComponent(id)}`, { method: "GET" });
});

document.getElementById("createBtn").addEventListener("click", async () => {
  const id = document.getElementById("rid").value;
  const payload = pick("c", CREATE_FIELDS);
  payload.id = id;
  await callApi(API, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-Tenant-Id": document.getElementById("tenant").value
    },
    body: JSON.stringify(payload)
  });
});

document.getElementById("updateBtn").addEventListener("click", async () => {
  const id = document.getElementById("rid").value;
  const payload = pick("u", UPDATE_FIELDS);
  await callApi(`${API}/${encodeURIComponent(id)}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload)
  });
});

document.getElementById("deleteBtn").addEventListener("click", async () => {
  const id = document.getElementById("rid").value;
  await callApi(`${API}/${encodeURIComponent(id)}`, { method: "DELETE" });
});

initFields();
</script>
</body>
</html>
HTML";

    auto result = html.replace("__TITLE__", def.title);
    result = result.replace("__API__", def.apiPath);
    result = result.replace("__CREATE_FIELDS__", def.createFields.serializeToJsonString());
    result = result.replace("__UPDATE_FIELDS__", def.updateFields.serializeToJsonString());
    return result;
}
