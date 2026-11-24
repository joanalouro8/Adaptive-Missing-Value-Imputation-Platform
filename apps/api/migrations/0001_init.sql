CREATE TABLE datasets(
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    r2_key TEXT NOT NULL UNIQUE,
    num_rows INTEGER,
    num_features INTEGER,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
)

CREATE TABLE experiments(
    id TEXT PRIMARY KEY,
    dataset_id NOT NULL references datasets(id),
    experiment_type TEXT NOT NULL, -- imputation_benchmark
    config_json TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'queued', 'running', 'completed', 'failed')),
    idempotency_key TEXT UNIQUE,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
)