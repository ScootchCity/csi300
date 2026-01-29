-- =============================================================================
-- NeoBank Seed Data
-- Assignment 02: SQL Fundamentals - DML (INSERT)
-- =============================================================================
-- This script should be IDEMPOTENT - uses ON CONFLICT DO NOTHING for repeatable runs
-- =============================================================================

-- =============================================================================
-- Account Types
-- Insert at least 5 account types:
--   - Basic Checking, Premium Checking, Savings, High-Yield Savings, Money Market
-- Use ON CONFLICT (name) DO NOTHING for idempotency
-- =============================================================================
-- TODO: Write your INSERT statements here

-- my code
INSERT INTO account_types (name, interest_rate)
VALUES
    ('Basic Checking', 0.0001),
    ('Premium Checking', 0.0015),
    ('Savings', 0.0125),
    ('High Yield Savings', 0.0375),
    ('Money Market', 0.0450)
ON CONFLICT DO NOTHING;

-- =============================================================================
-- Customers
-- Insert at least 10 customers with varied:
--   - KYC statuses (pending, verified, rejected)
--   - Email domains (gmail, yahoo, outlook, etc.)
--   - Created dates (use INTERVAL for relative dates)
-- Tip: Use encode(sha256('value'::bytea), 'hex') for ssn_hash
-- Use ON CONFLICT (email) DO NOTHING for idempotency
-- =============================================================================
-- TODO: Write your INSERT statements here

-- my code
INSERT INTO customers (email, first_name, last_name, date_of_birth, ssn_hash, kyc_status, created_at)
VALUES
    ('johndoe@gmail.com', 'John', 'Doe', '1999-01-01', encode(sha256('849237183'::bytea), 'hex'), 'pending', CURRENT_TIMESTAMP - INTERVAL '3 months'),
    ('johnnyappleseed@me.com', 'Johnny', 'Appleseed', '1774-09-26', encode(sha256('090283467'::bytea), 'hex'), 'verified', CURRENT_TIMESTAMP - INTERVAL '4 years 3 months 1 week'),
    ('nielsbohr@yahoo.com', 'Niels', 'Bohr', '1885-10-07', encode(sha256('177492014'::bytea), 'hex'), 'verified', CURRENT_TIMESTAMP - INTERVAL '3 weeks 2 days'),
    ('evil.guy32@gmail.com', 'Cave', 'Johnson', '1955-09-01', encode(sha256('189466378'::bytea), 'hex'), 'pending', CURRENT_TIMESTAMP - INTERVAL '1 week 5 days'),
    ('normal.student@mailservice.college.edu', 'Normal', 'Student', '2004-01-01', encode(sha256('988302651'::bytea), 'hex'), 'pending', CURRENT_TIMESTAMP - INTERVAL '1 day'),
    ('president@gmail.com', 'George', 'Washington', '1732-02-02', encode(sha256('557752781'::bytea), 'hex'), 'rejected', CURRENT_TIMESTAMP - INTERVAL '12 years 2 months 3 days'),
    ('bjarne.stroustrup@me.com', 'Bjarne', 'Stroustrup', '1950-12-30', encode(sha256('444872994'::bytea), 'hex'), 'verified', CURRENT_TIMESTAMP - INTERVAL '1 month 3 days'),
    ('fred.durst@outlook.com', 'Fred', 'Durst', '1970-08-20', encode(sha256('193589327'::bytea), 'hex'), 'verified', CURRENT_TIMESTAMP - INTERVAL '8 months 2 days'),
    ('limpbizkitlover43@yahoo.com', 'Mette', 'Frederiksen', '1977-09-19', encode(sha256('817472988'::bytea), 'hex'), 'rejected', CURRENT_TIMESTAMP - INTERVAL '1 year 2 days'),
    ('chad.thaderson@gmail.com', 'Chad', 'Thaderson', '2007-04-16', encode(sha256('373782371'::bytea), 'hex'), 'pending', CURRENT_TIMESTAMP)
ON CONFLICT (email) DO NOTHING;

-- =============================================================================
-- Accounts
-- Insert accounts for customers, linking to account types
-- Tip: Use subqueries to get customer_id by email
-- Example: SELECT c.id FROM neobank.customers c WHERE c.email = 'email@example.com'
-- Use ON CONFLICT (account_number) DO NOTHING for idempotency
-- =============================================================================
-- TODO: Write your INSERT statements here

--my code
INSERT INTO accounts (customer_id, account_type, account_number, routing_number)
VALUES
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'johndoe@gmail.com'), 1, 122, 120000064),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'johnnyappleseed@me.com'), 2, 123, 120000064),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'nielsbohr@yahoo.com'), 3, 154, 120000064),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'evil.guy32@gmail.com'), 4, 162, 120000064),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'normal.student@mailservice.college.edu'), 5, 86, 120000064),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'president@gmail.com'), 1, 45, 120000064),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'bjarne.stroustrup@me.com'), 2, 89, 120000064),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'fred.durst@outlook.com'), 3, 134, 120000064),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'limpbizkitlover43@yahoo.com'), 4, 128, 120000064),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'chad.thaderson@gmail.com'), 5, 192, 120000064)
ON CONFLICT (account_number) DO NOTHING;

-- =============================================================================
-- Transactions
-- Insert various transaction types:
--   - Deposits (no source, has destination)
--   - Withdrawals (has source, no destination)
--   - Transfers (has both source and destination)
--   - Fees and interest transactions
-- Include various statuses: pending, completed, failed
-- Use ON CONFLICT (idempotency_key) DO NOTHING for idempotency
-- =============================================================================
-- TODO: Write your INSERT statements here

-- my code -- asked gemini for 5 random uuid for the idempotency keys
INSERT INTO transactions (idempotency_key, transaction_type, source_account_id, destination_account_id, amount, status)
VALUES
    ('7f0b5c1a-8e2d-4b9a-9c3f-1d8e4f5a6b7c', 'deposit', NULL, 134, 28.73, 'pending'),
    ('3d9e8f7a-2b1c-4d5e-8f9a-0b1c2d3e4f5a', 'withdrawal', 154, NULL, 150.00, 'failed'),
    ('a1b2c3d4-e5f6-4a5b-bc6d-7e8f9a0b1c2d', 'transfer', 89, 134, 35.00, 'reversed'),
    ('9e8d7c6b-5a4f-3e2d-1c0b-a9b8c7d6e5f4', 'fee', 128, NULL, 9.49, 'completed'),
    ('5f4e3d2c-1b0a-9f8e-7d6c-5b4a3f2e1d0c', 'interest', NULL, 122, 0.82, 'completed')
ON CONFLICT (idempotency_key) DO NOTHING;