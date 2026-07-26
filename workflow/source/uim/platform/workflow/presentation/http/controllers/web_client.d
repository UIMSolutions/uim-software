module uim.platform.workflow.presentation.http.controllers.web_client;

import uim.platform.workflow;

@safe:

class WorkflowWebClientController : SAPController {
    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/client", &handleClient);
    }

    private void handleClient(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto html = q"HTML
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Advanced Workflow Client</title>
<style>
:root {
  --ink: #102a43;
  --brand: #1f7a8c;
  --accent: #f2c14e;
  --paper: #f7f9fb;
  --card: #ffffff;
}
* { box-sizing: border-box; }
body {
  margin: 0;
  font-family: "IBM Plex Sans", "Segoe UI", sans-serif;
  color: var(--ink);
  background: radial-gradient(circle at 20% 10%, #d9f0f4, transparent 40%),
              radial-gradient(circle at 80% 0%, #ffe9b0, transparent 35%),
              var(--paper);
}
header {
  padding: 2rem 1rem 1rem 1rem;
  text-align: center;
}
h1 { margin: 0; font-size: 2rem; }
p { margin: 0.4rem 0 0 0; }
main {
  max-width: 920px;
  margin: 0 auto;
  padding: 1rem;
  display: grid;
  gap: 1rem;
}
.card {
  background: var(--card);
  border: 1px solid #d9e2ec;
  border-radius: 14px;
  padding: 1rem;
  box-shadow: 0 8px 20px rgba(16,42,67,.08);
}
label { display: block; margin-bottom: .3rem; font-weight: 600; }
input, select, textarea {
  width: 100%;
  padding: .65rem;
  border: 1px solid #bcccdc;
  border-radius: 10px;
  font-size: .95rem;
}
button {
  background: var(--brand);
  border: none;
  color: white;
  padding: .7rem 1rem;
  border-radius: 10px;
  cursor: pointer;
  font-weight: 700;
}
button.secondary { background: #486581; }
.actions { display: flex; gap: .6rem; flex-wrap: wrap; margin-top: .8rem; }
pre {
  background: #102a43;
  color: #e6f1f5;
  padding: .8rem;
  border-radius: 10px;
  overflow: auto;
}
@media (max-width: 700px) {
  h1 { font-size: 1.5rem; }
}
</style>
</head>
<body>
<header>
  <h1>Advanced Workflow Console</h1>
  <p>Create a workflow definition and inspect service data via REST.</p>
</header>
<main>
  <section class="card">
    <h2>Create Workflow Definition</h2>
    <label for="id">ID</label>
    <input id="id" value="WF-DEF-001" />
    <label for="name">Name</label>
    <input id="name" value="Purchase Request Approval" />
    <label for="category">Category</label>
    <input id="category" value="Procurement" />
    <label for="starterRole">Starter Role</label>
    <input id="starterRole" value="Requester" />
    <label for="priority">Priority</label>
    <select id="priority">
      <option>low</option>
      <option selected>normal</option>
      <option>high</option>
      <option>critical</option>
    </select>
    <label for="status">Status</label>
    <select id="status">
      <option>draft</option>
      <option selected>active</option>
      <option>suspended</option>
      <option>completed</option>
      <option>cancelled</option>
    </select>
    <div class="actions">
      <button id="create">Create</button>
      <button class="secondary" id="list">List Definitions</button>
    </div>
  </section>
  <section class="card">
    <h2>Response</h2>
    <pre id="out">Ready.</pre>
  </section>
</main>
<script>
const out = document.getElementById("out");
const tenant = "TEN-UI";

document.getElementById("create").addEventListener("click", async () => {
  const payload = {
    id: document.getElementById("id").value,
    name: document.getElementById("name").value,
    category: document.getElementById("category").value,
    starterRole: document.getElementById("starterRole").value,
    priority: document.getElementById("priority").value,
    status: document.getElementById("status").value,
    createdBy: "web-client"
  };

  const resp = await fetch("/api/v1/workflow/definitions", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-Tenant-Id": tenant
    },
    body: JSON.stringify(payload)
  });

  out.textContent = JSON.stringify(await resp.json(), null, 2);
});

document.getElementById("list").addEventListener("click", async () => {
  const resp = await fetch("/api/v1/workflow/definitions");
  out.textContent = JSON.stringify(await resp.json(), null, 2);
});
</script>
</body>
</html>
HTML";
        res.writeBody(html, 200, "text/html; charset=utf-8");
    }
}
