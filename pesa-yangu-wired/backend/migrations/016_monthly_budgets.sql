CREATE TABLE IF NOT EXISTS monthly_budgets (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  year        INT  NOT NULL,
  month       INT  NOT NULL CHECK (month BETWEEN 1 AND 12),
  budget_kes  NUMERIC(15,2) NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (user_id, category_id, year, month)
);
