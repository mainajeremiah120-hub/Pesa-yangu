-- Migration 002: Add refund transaction type

ALTER TABLE transactions DROP CONSTRAINT IF EXISTS transactions_type_check;

ALTER TABLE transactions
  ADD CONSTRAINT transactions_type_check
  CHECK (type IN ('expense','income','transfer_in','transfer_out','refund'));

ALTER TABLE transactions
  ADD COLUMN IF NOT EXISTS refund_of UUID REFERENCES transactions(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_tx_refund_of ON transactions(refund_of);