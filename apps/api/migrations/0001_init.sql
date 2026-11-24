CREATE TABLE datasets(
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    r2_key TEXT NOT NULL UNIQUE,
    num_rows INTEGER,
    num_features INTEGER,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
)

