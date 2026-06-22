-- PPM initial schema

CREATE TABLE IF NOT EXISTS ppm_portfolios (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    strategic_theme TEXT,
    status TEXT,
    planning_horizon TEXT,
    owner TEXT,
    budget_amount TEXT,
    currency TEXT,
    created_by TEXT,
    modified_by TEXT,
    created_at TEXT,
    modified_at TEXT
);

CREATE TABLE IF NOT EXISTS ppm_initiatives (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    portfolio_id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    category TEXT,
    priority TEXT,
    status TEXT,
    sponsor TEXT,
    expected_benefits TEXT,
    created_by TEXT,
    modified_by TEXT,
    created_at TEXT,
    modified_at TEXT
);

CREATE TABLE IF NOT EXISTS ppm_programs (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    portfolio_id TEXT NOT NULL,
    name TEXT NOT NULL,
    objective TEXT,
    status TEXT,
    manager TEXT,
    start_date TEXT,
    end_date TEXT,
    created_by TEXT,
    modified_by TEXT,
    created_at TEXT,
    modified_at TEXT
);

CREATE TABLE IF NOT EXISTS ppm_projects (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    program_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    project_type TEXT,
    status TEXT,
    start_date TEXT,
    end_date TEXT,
    project_manager TEXT,
    budget_amount TEXT,
    currency TEXT,
    created_by TEXT,
    modified_by TEXT,
    created_at TEXT,
    modified_at TEXT
);

CREATE TABLE IF NOT EXISTS ppm_demands (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    portfolio_id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    source TEXT,
    business_value TEXT,
    priority TEXT,
    status TEXT,
    requested_by TEXT,
    created_by TEXT,
    modified_by TEXT,
    created_at TEXT,
    modified_at TEXT
);

CREATE TABLE IF NOT EXISTS ppm_resource_requests (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    project_id TEXT NOT NULL,
    role TEXT NOT NULL,
    quantity TEXT,
    allocation_percent TEXT,
    start_date TEXT,
    end_date TEXT,
    status TEXT,
    requested_by TEXT,
    created_by TEXT,
    modified_by TEXT,
    created_at TEXT,
    modified_at TEXT
);
