module uim.platform.mm.presentation.http.controllers.web_client;

import uim.platform.mm;

@safe:

class MmWebClientController : SAPController {
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
<title>Material Management Console</title>
<style>
:root {
  --ink: #17324d;
  --brand: #0f766e;
  --accent: #e76f51;
  --mist: #edf6f4;
  --card: rgba(255,255,255,.92);
}
* { box-sizing: border-box; }
body {
  margin: 0;
  font-family: "IBM Plex Sans", "Segoe UI", sans-serif;
  color: var(--ink);
  background:
    radial-gradient(circle at 10% 10%, rgba(15,118,110,.16), transparent 32%),
    radial-gradient(circle at 85% 15%, rgba(231,111,81,.18), transparent 24%),
    linear-gradient(180deg, #f9fcfb 0%, #edf6f4 100%);
}
header {
  padding: 2rem 1rem 1rem;
  text-align: center;
}
h1 { margin: 0; font-size: 2rem; }
p { margin: .4rem 0 0; }
main {
  max-width: 1100px;
  margin: 0 auto;
  padding: 1rem;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1rem;
}
.card {
  background: var(--card);
  border: 1px solid rgba(23,50,77,.12);
  border-radius: 18px;
  padding: 1rem;
  box-shadow: 0 18px 40px rgba(23,50,77,.08);
  backdrop-filter: blur(8px);
}
label { display: block; font-weight: 700; margin: .75rem 0 .3rem; }
input, select, textarea {
  width: 100%;
  border: 1px solid #c5d8d5;
  border-radius: 12px;
  padding: .7rem .8rem;
  font: inherit;
  background: white;
}
button {
  border: none;
  border-radius: 999px;
  padding: .75rem 1rem;
  font: inherit;
  font-weight: 700;
  cursor: pointer;
  background: var(--brand);
  color: white;
}
button.secondary {
  background: #244b64;
}
.actions { display: flex; flex-wrap: wrap; gap: .6rem; margin-top: 1rem; }
pre {
  margin: 0;
  min-height: 280px;
  background: #11263a;
  color: #ddf4ff;
  border-radius: 14px;
  padding: .9rem;
  overflow: auto;
}
.hero {
  grid-column: 1 / -1;
  display: grid;
  gap: 1rem;
  grid-template-columns: 1.2fr .8fr;
}
@media (max-width: 900px) {
  .hero { grid-template-columns: 1fr; }
}
</style>
</head>
<body>
<header>
  <h1>Material Management Console</h1>
  <p>Prototype the MM flow from requisition to goods receipt using the embedded vibe.d client.</p>
</header>
<main>
  <section class="card hero">
    <div>
      <h2>Procurement Flow</h2>
      <label for="requisitionId">Requisition ID</label>
      <input id="requisitionId" value="PR-1000" />
      <label for="materialId">Material ID</label>
      <input id="materialId" value="MAT-1000" />
      <label for="plantId">Plant ID</label>
      <input id="plantId" value="PLANT-1000" />
      <label for="storageLocationId">Storage Location ID</label>
      <input id="storageLocationId" value="SL-1000" />
      <label for="vendorId">Vendor ID</label>
      <input id="vendorId" value="VEN-1000" />
      <label for="quantity">Quantity</label>
      <input id="quantity" value="25" />
      <label for="netPrice">Net Price</label>
      <input id="netPrice" value="145.50" />
      <div class="actions">
        <button id="seedMasterData">Seed Master Data</button>
        <button id="createReq">Create Requisition</button>
        <button id="convertReq">Convert To Order</button>
        <button id="postReceipt">Post Goods Receipt</button>
      </div>
    </div>
    <div>
      <h2>Inspect</h2>
      <div class="actions">
        <button class="secondary" id="listReqs">List Requisitions</button>
        <button class="secondary" id="listOrders">List Orders</button>
        <button class="secondary" id="listStock">List Stock</button>
      </div>
      <p style="margin-top: 1rem;">Tenant header used by the client: <strong>TEN-UI</strong></p>
    </div>
  </section>
  <section class="card" style="grid-column: 1 / -1;">
    <h2>Response</h2>
    <pre id="out">Ready.</pre>
  </section>
</main>
<script>
const out = document.getElementById("out");
const tenant = "TEN-UI";

async function callApi(path, method, payload) {
  const response = await fetch(path, {
    method,
    headers: {
      "Content-Type": "application/json",
      "X-Tenant-Id": tenant
    },
    body: payload ? JSON.stringify(payload) : undefined
  });

  const text = await response.text();
  try {
    out.textContent = JSON.stringify(JSON.parse(text), null, 2);
  } catch {
    out.textContent = text;
  }
}

function ids() {
  return {
    requisitionId: document.getElementById("requisitionId").value,
    materialId: document.getElementById("materialId").value,
    plantId: document.getElementById("plantId").value,
    storageLocationId: document.getElementById("storageLocationId").value,
    vendorId: document.getElementById("vendorId").value,
    quantity: document.getElementById("quantity").value,
    netPrice: document.getElementById("netPrice").value,
  };
}

document.getElementById("seedMasterData").addEventListener("click", async () => {
  const data = ids();
  await callApi("/api/v1/mm/materials", "POST", {
    id: data.materialId,
    materialNumber: data.materialId,
    description: "Valve Assembly",
    baseUnit: "EA",
    materialType: "rawMaterial",
    materialGroup: "SPARES",
    valuationClass: "3000",
    createdBy: "web-client"
  });
  await callApi("/api/v1/mm/plants", "POST", {
    id: data.plantId,
    plantCode: "1000",
    name: "Main Plant",
    companyCode: "1000",
    country: "DE",
    purchasingOrg: "P100",
    createdBy: "web-client"
  });
  await callApi("/api/v1/mm/storage-locations", "POST", {
    id: data.storageLocationId,
    plantId: data.plantId,
    storageLocationCode: "0001",
    name: "Central Warehouse",
    description: "Main stock",
    createdBy: "web-client"
  });
  await callApi("/api/v1/mm/vendors", "POST", {
    id: data.vendorId,
    vendorNumber: "700001",
    name: "Preferred Industrial Supply",
    purchasingOrg: "P100",
    currency: "EUR",
    paymentTerms: "0001",
    incoterms: "DAP",
    createdBy: "web-client"
  });
  await callApi("/api/v1/mm/purchasing-info-records", "POST", {
    id: "PIR-" + data.materialId,
    materialId: data.materialId,
    vendorId: data.vendorId,
    plantId: data.plantId,
    purchasingOrg: "P100",
    orderUnit: "EA",
    netPrice: data.netPrice,
    currency: "EUR",
    leadTimeDays: "5",
    minimumOrderQuantity: "1",
    sourceListNote: "Preferred source",
    createdBy: "web-client"
  });
});

document.getElementById("createReq").addEventListener("click", async () => {
  const data = ids();
  await callApi("/api/v1/mm/purchase-requisitions", "POST", {
    id: data.requisitionId,
    materialId: data.materialId,
    plantId: data.plantId,
    storageLocationId: data.storageLocationId,
    quantity: data.quantity,
    unit: "EA",
    requiredDate: "2026-08-15",
    requestedBy: "web-client",
    sourceVendorId: data.vendorId
  });
});

document.getElementById("convertReq").addEventListener("click", async () => {
  const data = ids();
  await callApi("/api/v1/mm/purchase-requisition-conversions/" + data.requisitionId, "POST", {
    id: "PO-" + data.requisitionId,
    vendorId: data.vendorId,
    purchasingOrg: "P100",
    currency: "EUR",
    netPrice: data.netPrice,
    orderedBy: "web-client"
  });
});

document.getElementById("postReceipt").addEventListener("click", async () => {
  const data = ids();
  await callApi("/api/v1/mm/goods-receipts", "POST", {
    id: "GR-" + data.requisitionId,
    purchaseOrderId: "PO-" + data.requisitionId,
    plantId: data.plantId,
    storageLocationId: data.storageLocationId,
    materialId: data.materialId,
    movementType: "goodsReceipt",
    quantity: data.quantity,
    postedBy: "web-client",
    postingDate: "2026-08-01"
  });
});

document.getElementById("listReqs").addEventListener("click", () => callApi("/api/v1/mm/purchase-requisitions", "GET"));
document.getElementById("listOrders").addEventListener("click", () => callApi("/api/v1/mm/purchase-orders", "GET"));
document.getElementById("listStock").addEventListener("click", () => callApi("/api/v1/mm/stock-items", "GET"));
</script>
</body>
</html>
HTML";
        res.writeBody(html, 200, "text/html; charset=utf-8");
    }
}