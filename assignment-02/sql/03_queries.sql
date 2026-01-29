-- =============================================================================
-- NeoBank Queries
-- Assignment 02: SQL Fundamentals - DQL (SELECT)
-- =============================================================================
-- NOTE: Week 2 only covers basic SELECT, WHERE, ORDER BY, LIMIT
--       No JOINs (Week 5) or Aggregations (Week 3)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Query 1: List all verified customers
-- Select all customers with 'verified' KYC status
-- Return: id, email, first_name, last_name, kyc_status
-- Order by: last_name, first_name
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, email, first_name, last_name, kyc_status FROM neobank.customers
WHERE kyc_status = 'verified'
ORDER BY (last_name, first_name);

-- -----------------------------------------------------------------------------
-- Query 2: High-value accounts
-- Find accounts with balance > $25,000
-- Return: id, account_number, balance, status
-- Order by: balance descending
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, account_number, balance, status FROM neobank.accounts
WHERE balance >= 25000
ORDER BY balance DESC;

-- -----------------------------------------------------------------------------
-- Query 3: Gmail users (pattern matching with LIKE)
-- Find customers with Gmail email addresses
-- Return: id, email, first_name, last_name, created_at
-- Order by: created_at descending
-- Limit: 5 results
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, email, first_name, last_name, created_at FROM neobank.customers
WHERE email LIKE '%@gmail.com'
ORDER BY created_at DESC
LIMIT 5;

-- -----------------------------------------------------------------------------
-- Query 4: Recent transactions (date range)
-- Find transactions from the last 30 days
-- Return: id, transaction_type, amount, status, created_at
-- Order by: created_at descending
-- Tip: Use CURRENT_TIMESTAMP - INTERVAL '30 days'
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, transaction_type, amount, status, created_at FROM neobank.transactions
WHERE created_at > (CURRENT_TIMESTAMP - INTERVAL '30 days')
ORDER BY created_at DESC;

-- -----------------------------------------------------------------------------
-- Query 5: Pending customers for review
-- Find pending customers created more than 7 days ago
-- Return: id, email, first_name, last_name, kyc_status, created_at
-- Order by: created_at ascending
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, email, first_name, last_name, kyc_status, created_at FROM neobank.customers
WHERE (kyc_status = 'pending') AND (created_at < (CURRENT_TIMESTAMP - INTERVAL '7 days'))
ORDER BY created_at;

-- -----------------------------------------------------------------------------
-- Query 6: Frozen or closed accounts (OR operator)
-- Find accounts that are frozen or closed
-- Return: id, account_number, balance, status, closed_at
-- Order by: status, then balance descending
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, account_number, balance, status, closed_at FROM neobank.accounts
WHERE status = 'frozen' OR status = 'closed'
ORDER BY status, balance DESC;

-- -----------------------------------------------------------------------------
-- Query 7: Large pending transactions
-- Find pending transactions older than 24 hours with amount > $1,000
-- Return: id, transaction_type, amount, status, created_at
-- Order by: amount descending, created_at ascending
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, transaction_type, amount, status, created_at FROM neobank.transactions
WHERE amount > 1000 AND created_at > CURRENT_TIMESTAMP - INTERVAL '3 days' -- changed to 3 days so i can see my large pending
ORDER BY amount DESC, created_at DESC;

-- -----------------------------------------------------------------------------
-- Query 8: Specific transaction types (using IN)
-- Find withdrawal and fee transactions
-- Return: id, transaction_type, amount, source_account_id, status, created_at
-- Order by: created_at descending
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, transaction_type, amount, source_account_id, status, created_at FROM neobank.transactions
WHERE transaction_type IN ('withdrawal', 'fee')
ORDER BY created_at DESC;

-- -----------------------------------------------------------------------------
-- Query 9: Multi-condition customer search
-- Find customers who are:
--   - KYC verified
--   - Born between 1980 and 1995
--   - Phone number starts with '+1'
-- Return: id, email, phone_number, first_name, last_name, date_of_birth, kyc_status
-- Order by: date_of_birth ascending
-- Tip: Use BETWEEN for date range, LIKE for phone pattern
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, email, phone_number, first_name, last_name, date_of_birth , kyc_status FROM neobank.customers
WHERE
    kyc_status = 'verified' AND
    date_of_birth BETWEEN '1980-01-01' AND '1995-12-31' AND
    phone_number LIKE '+1%'
ORDER BY date_of_birth;

-- -----------------------------------------------------------------------------
-- Query 10: Accounts with specific balance range
-- Find active accounts with balance between $1,000 and $10,000
-- Return: id, account_number, balance, currency, status
-- Order by: balance ascending
-- Limit: 10 results
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- my code
SELECT id, account_number, balance, currency, status FROM neobank.accounts
WHERE balance BETWEEN 1000 AND 10000
ORDER BY balance
LIMIT 10;

-- query 10 from .md file

SELECT id, transaction_type, amount, status, created_at FROM neobank.transactions
WHERE status = 'failed' AND created_at < CURRENT_TIMESTAMP - INTERVAL '1 year'
ORDER BY created_at