-- Add opening_balance to wallets so it can be tracked and edited separately from current balance
ALTER TABLE wallets ADD COLUMN IF NOT EXISTS opening_balance NUMERIC(15,2) NOT NULL DEFAULT 0;

-- For existing wallets set opening_balance to their current balance as a starting point
-- (best approximation since we don't have historical creation-time balances)
UPDATE wallets SET opening_balance = balance WHERE opening_balance = 0;
