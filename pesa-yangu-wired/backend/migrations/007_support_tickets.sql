-- Migration 007: Support ticket system
CREATE TABLE IF NOT EXISTS support_tickets (
  id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id    UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  subject    TEXT        NOT NULL,
  message    TEXT        NOT NULL,
  category   TEXT        NOT NULL DEFAULT 'general'
             CHECK (category IN ('general','billing','bug','account','data','other')),
  status     TEXT        NOT NULL DEFAULT 'open'
             CHECK (status IN ('open','in_progress','resolved','closed')),
  priority   TEXT        NOT NULL DEFAULT 'normal'
             CHECK (priority IN ('low','normal','high','urgent')),
  admin_reply   TEXT,
  replied_by    UUID     REFERENCES users(id) ON DELETE SET NULL,
  replied_at    TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_tickets_user   ON support_tickets(user_id);
CREATE INDEX IF NOT EXISTS idx_tickets_status ON support_tickets(status);
