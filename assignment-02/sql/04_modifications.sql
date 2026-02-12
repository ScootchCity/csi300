-- =============================================================================
-- NeoBank Data Modifications
-- Assignment 02: SQL Fundamentals - DML (UPDATE & DELETE)
-- =============================================================================
-- NOTE: Week 2 only - no JOINs in UPDATE/DELETE statements
-- =============================================================================

-- =============================================================================
-- UPDATE OPERATIONS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Update 1: KYC Batch Update
-- Reject pending customers created more than 7 days ago
-- Set kyc_status to 'rejected' and update the updated_at timestamp
-- -----------------------------------------------------------------------------
-- TODO: Write your UPDATE statement here

-- my code
UPDATE neobank.customers
SET
    kyc_status = 'rejected',
    updated_at = CURRENT_TIMESTAMP
WHERE
    kyc_status = 'pending' AND
    created_at < CURRENT_TIMESTAMP - INTERVAL '7 days';

-- -----------------------------------------------------------------------------
-- Update 2: Interest Rate Adjustment
-- Increase all savings account interest rates by 0.5% (0.0050)
-- Cap at maximum 1.0 (use LEAST function)
-- Target: account types with 'Savings' in the name
-- -----------------------------------------------------------------------------
-- TODO: Write your UPDATE statement here

-- my code
UPDATE neobank.account_types
SET
    interest_rate = LEAST (interest_rate + 0.0050, 1.0)
WHERE
    name LIKE '%Savings%';

-- -----------------------------------------------------------------------------
-- Update 3: Process Pending Fees
-- Complete pending fee and interest transactions
-- Set status to 'completed' and processed_at to current timestamp
-- -----------------------------------------------------------------------------
-- TODO: Write your UPDATE statement here

-- my code
UPDATE neobank.transactions
SET
    status = 'completed',
    processed_at = CURRENT_TIMESTAMP
WHERE
    status = 'pending' AND
    transaction_type IN ('fee', 'interest');

-- -----------------------------------------------------------------------------
-- Update 4: Freeze Low Balance Accounts
-- Freeze active accounts with balance <= 0
-- Set status to 'frozen'
-- -----------------------------------------------------------------------------
-- TODO: Write your UPDATE statement here

-- my code
UPDATE neobank.accounts
SET
    status = 'frozen'
WHERE
    status = 'active' AND
    balance <= 0;

-- -----------------------------------------------------------------------------
-- Update 5: Add Bonus to Loyal Accounts
-- Add $50 bonus to active accounts that:
--   - Were opened more than 90 days ago
--   - Have balance greater than $1,000
-- -----------------------------------------------------------------------------
-- TODO: Write your UPDATE statement here

-- my code
UPDATE neobank.accounts
SET
    balance = balance + 50
WHERE
    status = 'active' AND
    opened_at < CURRENT_TIMESTAMP - INTERVAL '90 days' AND
    balance > 1000;

-- =============================================================================
-- DELETE OPERATIONS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Delete 1: Cleanup Failed Transactions
-- Remove failed transactions older than 1 year
-- -----------------------------------------------------------------------------
-- TODO: Write your DELETE statement here

-- my code
DELETE FROM neobank.transactions
WHERE
    status = 'failed' AND
    created_at < CURRENT_TIMESTAMP - INTERVAL '1 year';

-- -----------------------------------------------------------------------------
-- Delete 2: Remove Test Data
-- Delete test customers (email ending with @test.neobank.local)
-- Note: Due to CASCADE, this will also delete their accounts
-- But transactions referencing those accounts need manual cleanup first
-- 
-- Steps:
--   1. First, query to find the IDs of test customers (WHERE email LIKE '%@test.neobank.local')
--   2. Delete transactions WHERE account_id IN (list of test account IDs)
--   3. Delete accounts WHERE customer_id IN (list of test customer IDs)
--   4. Delete the test customers WHERE email LIKE '%@test.neobank.local'
-- Tip: You can run SELECT queries first to identify the IDs, then use them in DELETE
-- -----------------------------------------------------------------------------
-- TODO: Write your DELETE statements here (multiple steps)

DELETE FROM neobank.transactions
WHERE
    source_account_id IN (
        SELECT a.id FROM neobank.accounts a
        WHERE a.customer_id IN (
            SELECT c.id FROM neobank.customers c
            WHERE c.email LIKE '%@test.neobank.local'
        )
    ) OR
    destination_account_id IN (
        SELECT a.id FROM neobank.accounts a
        WHERE a.customer_id IN (
            SELECT c.id FROM neobank.customers c
            WHERE c.email LIKE '%@test.neobank.local'
        )
    );

DELETE FROM neobank.accounts
WHERE
    customer_id IN (
        SELECT id FROM neobank.customers
        WHERE email LIKE '%test.neobank.local'
    );

DELETE FROM neobank.customers
WHERE email LIKE '%@test.neobank.local';

-- =============================================================================
-- VERIFICATION QUERIES
-- Run these after your modifications to verify results
-- =============================================================================

-- Check KYC status distribution after Update 1
SELECT kyc_status, COUNT(*) 
FROM neobank.customers 
GROUP BY kyc_status
ORDER BY kyc_status;

-- Check interest rates after Update 2
SELECT name, interest_rate 
FROM neobank.account_types 
WHERE name LIKE '%Savings%';

-- Check account statuses after Update 4
SELECT status, COUNT(*) 
FROM neobank.accounts 
GROUP BY status
ORDER BY status;

-- Verify test data removed after Delete 2
SELECT COUNT(*) AS remaining_test_customers
FROM neobank.customers 
WHERE email LIKE '%@test.neobank.local';
