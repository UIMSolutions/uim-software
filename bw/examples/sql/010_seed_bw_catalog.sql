-- Seed catalog data for bw_objects.
-- This script is idempotent and can be executed multiple times.

INSERT INTO bw_objects (
    id, object_type, tenant_id, technical_name, business_name, semantic_layer,
    source_system, lifecycle_state, parent_id, owner, description,
    external_reference, created_by, modified_by, created_at, modified_at, metadata_json
) VALUES
(
    'IA-SALES', 'info-areas', 'default', 'ZIA_SALES', 'Sales Info Area', 'Metadata',
    'BW', 'active', '', 'dwh.team', 'Top-level sales area',
    'sap-bw://info-area/ZIA_SALES', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"domain":"sales","criticality":"high"}'
),
(
    'IO-CUSTOMER', 'info-objects', 'default', '0CUSTOMER', 'Customer', 'Master Data',
    'S4H', 'active', 'IA-SALES', 'dwh.team', 'Customer master object',
    'sap-bw://info-object/0CUSTOMER', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"kind":"characteristic"}'
),
(
    'IO-NETVAL', 'key-figures', 'default', '0NETVAL', 'Net Value', 'Measure',
    'S4H', 'active', 'IA-SALES', 'dwh.team', 'Net value key figure',
    'sap-bw://key-figure/0NETVAL', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"kind":"key-figure","unit":"currency"}'
),
(
    'DS-BILLING', 'data-sources', 'default', '2LIS_13_VDITM', 'Billing Item DataSource', 'Extraction',
    'S4H', 'active', '', 'integration.team', 'ERP billing extractor',
    'sap-bw://datasource/2LIS_13_VDITM', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"delta":"enabled"}'
),
(
    'TR-BILL-ADSO', 'transformations', 'default', 'TR_BILL_TO_ADSO', 'Billing to ADSO Transform', 'Transformation',
    'BW', 'active', 'DS-BILLING', 'integration.team', 'Maps billing extractor to ADSO target',
    'sap-bw://transformation/TR_BILL_TO_ADSO', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"source":"2LIS_13_VDITM","target":"ADSO-SALES"}'
),
(
    'DTP-BILL-ADSO', 'data-transfer-processes', 'default', 'DTP_BILL_TO_ADSO', 'Billing DTP', 'Data Flow',
    'BW', 'active', 'TR-BILL-ADSO', 'integration.team', 'Loads billing data into ADSO',
    'sap-bw://dtp/DTP_BILL_TO_ADSO', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"mode":"delta"}'
),
(
    'ADSO-SALES', 'adsos', 'default', 'ZADSO_SALES', 'Sales ADSO', 'Storage',
    'BW', 'active', '', 'dwh.team', 'Persistent sales data object',
    'sap-bw://adso/ZADSO_SALES', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"type":"standard"}'
),
(
    'CP-SALES', 'composite-providers', 'default', 'ZCP_SALES', 'Sales Composite Provider', 'Virtual Model',
    'BW', 'active', 'ADSO-SALES', 'analytics.team', 'Virtual provider for sales analytics',
    'sap-bw://composite-provider/ZCP_SALES', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"federation":"enabled"}'
),
(
    'Q-SALES-MARGIN', 'queries', 'default', 'ZQ_SALES_MARGIN', 'Sales Margin Query', 'Consumption',
    'BW', 'active', 'CP-SALES', 'analytics.team', 'Query for margin reporting',
    'sap-bw://query/ZQ_SALES_MARGIN', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"currency":"EUR","refresh":"hourly"}'
),
(
    'DF-SALES-PIPE', 'data-flows', 'default', 'ZDF_SALES_PIPE', 'Sales Pipeline Flow', 'Orchestration',
    'BW', 'active', 'DS-BILLING', 'integration.team', 'Data flow from source extraction to query model',
    'sap-bw://data-flow/ZDF_SALES_PIPE', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"stages":"extract,transform,load,serve"}'
),
(
    'API-Q-EXEC', 'api-definitions', 'default', 'BW_QUERY_EXEC', 'Query Execution API', 'API',
    'BDC', 'active', '', 'platform.team', 'Endpoint contract for query execution',
    'https://api.example/bw/query-executions', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"method":"POST","path":"/api/v1/bw/query-executions"}'
),
(
    'API-MODEL-SRCH', 'api-definitions', 'default', 'BW_MODEL_SEARCH', 'Model Search API', 'API',
    'BDC', 'active', '', 'platform.team', 'Endpoint contract for model discovery',
    'https://api.example/bw/search/models', 'seed', 'seed', CURRENT_TIMESTAMP::text, CURRENT_TIMESTAMP::text,
    '{"method":"GET","path":"/api/v1/bw/search/models"}'
)
ON CONFLICT (object_type, id)
DO UPDATE SET
    tenant_id = EXCLUDED.tenant_id,
    technical_name = EXCLUDED.technical_name,
    business_name = EXCLUDED.business_name,
    semantic_layer = EXCLUDED.semantic_layer,
    source_system = EXCLUDED.source_system,
    lifecycle_state = EXCLUDED.lifecycle_state,
    parent_id = EXCLUDED.parent_id,
    owner = EXCLUDED.owner,
    description = EXCLUDED.description,
    external_reference = EXCLUDED.external_reference,
    modified_by = EXCLUDED.modified_by,
    modified_at = CURRENT_TIMESTAMP::text,
    metadata_json = EXCLUDED.metadata_json;
