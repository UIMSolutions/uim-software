module uim.platform.workflow.presentation.http.controllers.openapi;

import uim.platform.workflow;

@safe:

string workflowOpenApiYamlSpec() {
    return q"OAS
openapi: 3.0.3
info:
  title: Advanced Workflow Service API
  version: 1.0.0
  description: SAP Advanced Workflow inspired API with compatibility routes.
servers:
  - url: /
paths:
  /health:
    get:
      summary: Service health
      responses:
        '200': { description: OK }
  /api/v1/health:
    get:
      summary: API health
      responses:
        '200': { description: OK }
  /api/v1/workflow/definitions:
    get: { summary: List workflow definitions, responses: { '200': { description: OK } } }
    post: { summary: Create workflow definition, responses: { '201': { description: Created } } }
  /api/v1/workflow/instances:
    get: { summary: List workflow instances, responses: { '200': { description: OK } } }
    post: { summary: Create workflow instance, responses: { '201': { description: Created } } }
  /api/v1/workflow/tasks:
    get: { summary: List workflow tasks, responses: { '200': { description: OK } } }
    post: { summary: Create workflow task, responses: { '201': { description: Created } } }
  /api/v1/workflow/decisions:
    get: { summary: List approval decisions, responses: { '200': { description: OK } } }
    post: { summary: Create approval decision, responses: { '201': { description: Created } } }
  /api/v1/workflow/deadlines:
    get: { summary: List deadline escalations, responses: { '200': { description: OK } } }
    post: { summary: Create deadline escalation, responses: { '201': { description: Created } } }
  /api/v1/workflow/substitutions:
    get: { summary: List substitutions, responses: { '200': { description: OK } } }
    post: { summary: Create substitution, responses: { '201': { description: Created } } }
  /api/v1/workflow/contexts:
    get: { summary: List workflow contexts, responses: { '200': { description: OK } } }
    post: { summary: Create workflow context, responses: { '201': { description: Created } } }
  /api/v1/workflow/events:
    get: { summary: List workflow events, responses: { '200': { description: OK } } }
    post: { summary: Create workflow event, responses: { '201': { description: Created } } }
  /api/v1/sap-advanced-workflow/workflow-definitions:
    get: { summary: SAP compatibility list definitions, responses: { '200': { description: OK } } }
    post: { summary: SAP compatibility create definition, responses: { '201': { description: Created } } }
  /api/v1/sap-advanced-workflow/workflow-instances:
    get: { summary: SAP compatibility list instances, responses: { '200': { description: OK } } }
    post: { summary: SAP compatibility create instance, responses: { '201': { description: Created } } }
  /api/v1/sap-advanced-workflow/workflow-tasks:
    get: { summary: SAP compatibility list tasks, responses: { '200': { description: OK } } }
    post: { summary: SAP compatibility create task, responses: { '201': { description: Created } } }
  /api/v1/sap-advanced-workflow/approval-decisions:
    get: { summary: SAP compatibility list decisions, responses: { '200': { description: OK } } }
    post: { summary: SAP compatibility create decision, responses: { '201': { description: Created } } }
  /api/v1/sap-advanced-workflow/deadline-escalations:
    get: { summary: SAP compatibility list escalations, responses: { '200': { description: OK } } }
    post: { summary: SAP compatibility create escalation, responses: { '201': { description: Created } } }
  /api/v1/sap-advanced-workflow/workflow-substitutions:
    get: { summary: SAP compatibility list substitutions, responses: { '200': { description: OK } } }
    post: { summary: SAP compatibility create substitution, responses: { '201': { description: Created } } }
  /api/v1/sap-advanced-workflow/workflow-contexts:
    get: { summary: SAP compatibility list contexts, responses: { '200': { description: OK } } }
    post: { summary: SAP compatibility create context, responses: { '201': { description: Created } } }
  /api/v1/sap-advanced-workflow/workflow-events:
    get: { summary: SAP compatibility list events, responses: { '200': { description: OK } } }
    post: { summary: SAP compatibility create event, responses: { '201': { description: Created } } }
OAS";
}

class WorkflowOpenApiController : SAPController {
    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/openapi.yaml", &handleOpenApiYaml);
    }

    private void handleOpenApiYaml(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = workflowOpenApiYamlSpec();
        res.writeBody(body, 200, "application/yaml; charset=utf-8");
    }
}
