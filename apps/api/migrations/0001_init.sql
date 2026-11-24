CREATE TABLE datasets(
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    r2_key TEXT NOT NULL UNIQUE,
    num_rows INTEGER,
    num_features INTEGER,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE experiments(
    id TEXT PRIMARY KEY,
    dataset_id NOT NULL references datasets(id),
    experiment_type TEXT NOT NULL, -- imputation_benchmark
    config_json TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'queued', 'running', 'completed', 'failed')),
    idempotency_key TEXT UNIQUE,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE experiment_runs (
    id TEXT PRIMARY KEY,
    experiment_id TEXT NOT NULL REFERENCES experiments(id),
    algorithm TEXT NOT NULL,
    params_json TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'running', 'completed', 'failed')),
    execution_time_ms INTEGER,
    error_message TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE experiment_results (
  id TEXT PRIMARY KEY,
  run_id TEXT NOT NULL REFERENCES experiment_runs(id),
  metric_name TEXT NOT NULL,
  metric_value REAL NOT NULL,
  artifact_r2_key TEXT, -- path to the reconstructed csv
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);


CREATE INDEX idx_experiments_dataset ON experiments(dataset_id);
CREATE INDEX idx_runs_experiment ON experiment_runs(experiment_id);
CREATE INDEX idx_results_run ON experiment_results(run_id);