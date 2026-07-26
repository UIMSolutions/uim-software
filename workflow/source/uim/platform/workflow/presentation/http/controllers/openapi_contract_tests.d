module uim.platform.workflow.presentation.http.controllers.openapi_contract_tests;

import uim.platform.workflow;

@safe unittest {
    auto spec = workflowOpenApiYamlSpec();
    assert(spec.length > 0);
    assert(spec.canFind("openapi: 3.0.3"));
    assert(spec.canFind("/api/v1/workflow/definitions"));
    assert(spec.canFind("/api/v1/workflow/instances"));
    assert(spec.canFind("/api/v1/workflow/tasks"));
    assert(spec.canFind("/api/v1/workflow/decisions"));
    assert(spec.canFind("/api/v1/workflow/deadlines"));
    assert(spec.canFind("/api/v1/workflow/substitutions"));
    assert(spec.canFind("/api/v1/workflow/contexts"));
    assert(spec.canFind("/api/v1/workflow/events"));
}

@safe unittest {
    auto spec = workflowOpenApiYamlSpec();
    assert(spec.canFind("/api/v1/sap-advanced-workflow/workflow-definitions"));
    assert(spec.canFind("/api/v1/sap-advanced-workflow/workflow-instances"));
    assert(spec.canFind("/api/v1/sap-advanced-workflow/workflow-tasks"));
    assert(spec.canFind("/api/v1/sap-advanced-workflow/approval-decisions"));
    assert(spec.canFind("/api/v1/sap-advanced-workflow/deadline-escalations"));
    assert(spec.canFind("/api/v1/sap-advanced-workflow/workflow-substitutions"));
    assert(spec.canFind("/api/v1/sap-advanced-workflow/workflow-contexts"));
    assert(spec.canFind("/api/v1/sap-advanced-workflow/workflow-events"));
}
