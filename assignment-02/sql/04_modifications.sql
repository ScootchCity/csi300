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


-- -----------------------------------------------------------------------------
-- Update 2: Interest Rate Adjustment
-- Increase all savings account interest rates by 0.5% (0.0050)
-- Cap at maximum 1.0 (use LEAST function)
-- Target: account types with 'Savings' in the name
-- -----------------------------------------------------------------------------
-- TODO: Write your UPDATE statement here


-- -----------------------------------------------------------------------------
-- Update 3: Process Pending Fees
-- Complete pending fee and interest transactions
-- Set status to 'completed' and processed_at to current timestamp
-- -----------------------------------------------------------------------------
-- TODO: Write your UPDATE statement here


-- -----------------------------------------------------------------------------
-- Update 4: Freeze Low Balance Accounts
-- Freeze active accounts with balance <= 0
-- Set status to 'frozen'
-- -----------------------------------------------------------------------------
-- TODO: Write your UPDATE statement here


-- -----------------------------------------------------------------------------
-- Update 5: Add Bonus to Loyal Accounts
-- Add $50 bonus to active accounts that:
--   - Were opened more than 90 days ago
--   - Have balance greater than $1,000
-- -----------------------------------------------------------------------------
-- TODO: Write your UPDATE statement here


-- =============================================================================
-- DELETE OPERATIONS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Delete 1: Cleanup Failed Transactions
-- Remove failed transactions older than 1 year
-- -----------------------------------------------------------------------------
-- TODO: Write your DELETE statement here


-- -----------------------------------------------------------------------------
-- Delete 2: Remove Test Data
-- Delete test customers (email ending with @test.neobank.local)
-- Note: Due to CASCADE, this will also delete their accounts
-- But transactions referencing those accounts need manual cleanup first
-- 
-- Steps:
--   1. Delete transactions referencing test customer accounts
--   2. Delete accounts (or let CASCADE handle it)
--   3. Delete the test customers
-- Tip: Use subqueries with IN to identify records
-- -----------------------------------------------------------------------------
-- TODO: Write your DELETE statements here (multiple steps)


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
