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
INSERT INTO neobank.account_types (name, interest_rate, minimum_balance, monthly_fee)
VALUES
    ('Basic Checking', 0.0001, 0.00, 4.99),
    ('Premium Checking', 0.0010, 1500.00, 0.00),
    ('Savings', 0.0250, 100.00, 0.00),
    ('High Yield Savings', 0.0450, 10000.00, 0.00),
    ('Money Market', 0.0350, 2500.00, 0.00)
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
INSERT INTO neobank.customers (email, phone_number, first_name, last_name, date_of_birth, ssn_hash, kyc_status, created_at)
VALUES
    ('johndoebank@test.neobank.local',
     '+14836729847',
     'John',
     'Doe',
     '1994-01-01',
     encode(sha256('849237183'::bytea), 'hex'),
     'pending',
     CURRENT_TIMESTAMP - INTERVAL '3 months'),
    ('johnnyappleseed@me.com',
     '+18847234892',
     'Johnny',
     'Appleseed',
     '1774-09-26',
     encode(sha256('090283467'::bytea), 'hex'),
     'verified',
     CURRENT_TIMESTAMP - INTERVAL '4 years 3 months 1 week'),
    ('nielsbohr@yahoo.com',
     '+18372780992',
     'Niels',
     'Bohr',
     '1885-10-07',
     encode(sha256('177492014'::bytea), 'hex'),
     'verified',
     CURRENT_TIMESTAMP - INTERVAL '3 weeks 2 days'),
    ('evil.guy32@gmail.com',
     '+17882772834',
     'Cave',
     'Johnson',
     '1955-09-01',
     encode(sha256('189466378'::bytea), 'hex'),
     'pending',
     CURRENT_TIMESTAMP - INTERVAL '1 week 5 days'),
    ('normal.student@mailservice.college.edu',
     '+18443782123',
     'Normal',
     'Student',
     '2004-01-01',
     encode(sha256('988302651'::bytea), 'hex'),
     'pending',
     CURRENT_TIMESTAMP - INTERVAL '1 day'),
    ('president@gmail.com',
     '+16662876364',
     'George',
     'Washington',
     '1732-02-02',
     encode(sha256('557752781'::bytea), 'hex'),
     'rejected',
     CURRENT_TIMESTAMP - INTERVAL '12 years 2 months 3 days'),
    ('bjarne.stroustrup@me.com',
     '+4553597236',
     'Bjarne',
     'Stroustrup',
     '1950-12-30',
     encode(sha256('444872994'::bytea), 'hex'),
     'verified',
     CURRENT_TIMESTAMP - INTERVAL '1 month 3 days'),
    ('fred.durst@outlook.com',
     '+14204206969',
     'Fred',
     'Durst',
     '1970-08-20',
     encode(sha256('193589327'::bytea), 'hex'),
     'verified',
     CURRENT_TIMESTAMP - INTERVAL '8 months 2 days'),
    ('limpbizkitlover43@yahoo.com',
     '+4587345675',
     'Mette',
     'Frederiksen',
     '1977-09-19',
     encode(sha256('817472988'::bytea), 'hex'),
     'rejected',
     CURRENT_TIMESTAMP - INTERVAL '1 year 2 days'),
    ('chad.thaderson@gmail.com',
     '+17546237887',
     'Chad',
     'Thaderson',
     '2007-04-16',
     encode(sha256('373782371'::bytea), 'hex'),
     'pending',
     CURRENT_TIMESTAMP)
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
INSERT INTO neobank.accounts (customer_id, account_type_id, account_number, routing_number, balance, currency, status, opened_at)
VALUES
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'johndoebank@test.neobank.local'),
     1,
     9000298123229723,
     021000021,
     3000.00,
     'USD',
     'frozen',
     CURRENT_TIMESTAMP - INTERVAL '5 years'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'johnnyappleseed@me.com'),
     2,
     5023465571413929,
     021000021,
     8000.00,
     'USD',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '2 years'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'nielsbohr@yahoo.com'),
     3,
     3148240913200091,
     021000021,
     500.00,
     'USD',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '10 weeks'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'evil.guy32@gmail.com'),
     4,
     3130978135552839,
     021000021,
     50000.00,
     'USD',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '8 months 3 days'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'normal.student@mailservice.college.edu'),
     1,
     6649695620682599,
     021000021,
     15,
     'USD',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '1 day'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'president@gmail.com'),
     1,
     7704647441060837,
     021000021,
     32000.000,
     'USD',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '200 years'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'bjarne.stroustrup@me.com'),
     2,
     4468894114404187,
     021000021,
     38400.00,
     'DKK',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '82 years 4 weeks'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'bjarne.stroustrup@me.com'),
     1,
     4118443729533977,
     021000021,
     2500.00,
     'DKK',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '12 years 3 weeks 2 days'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'bjarne.stroustrup@me.com'),
     3,
     0167390090015143,
     021000021,
     12000.00,
     'DKK',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '3 years 4 months'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'fred.durst@outlook.com'),
     3,
     1351905003432579,
     021000021,
     102.00,
     'USD',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '3 years'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'fred.durst@outlook.com'),
     4,
     6781355615651125,
     021000021,
     3287000.00,
     'USD',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '3 years'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'fred.durst@outlook.com'),
     5,
     3083360880236189,
     021000021,
     45800.00,
     'USD',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '3 years'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'limpbizkitlover43@yahoo.com'),
     4,
     7643528817368679,
     021000021,
     4204890.00,
     'DKK',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '8 years 4 months'),
    ((SELECT c.id FROM neobank.customers c WHERE c.email = 'chad.thaderson@gmail.com'),
     5,
     9233167650075879,
     021000021,
     2500.00,
     'USD',
     'active',
     CURRENT_TIMESTAMP - INTERVAL '2 months')
ON CONFLICT (account_number) DO NOTHING;

INSERT INTO neobank.accounts (customer_id, account_type_id, account_number, routing_number, balance, currency, status, opened_at, closed_at)
VALUES
((SELECT c.id FROM neobank.customers c WHERE c.email = 'johndoebank@test.neobank.local'), -- separate insert for closed_at
     2,
     7567763417759112,
     021000021,
     12000.00,
     'USD',
     'closed',
     CURRENT_TIMESTAMP - INTERVAL '3 years',
     CURRENT_TIMESTAMP - INTERVAL '1 year')
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

-- my code -- asked gemini for 30 random uuid for the idempotency keys
INSERT INTO neobank.transactions (idempotency_key, transaction_type, source_account_id, destination_account_id, amount, currency, description, status, created_at)
VALUES
    -- pending > 24h, amount > $1,000
    ('e8b2a1c4-9d3e-4f0b-a1b2-c3d4e5f6a7b8', 'deposit', NULL, 12, 1250.00, 'USD', 'big deposit', 'pending', CURRENT_TIMESTAMP - INTERVAL '2 days'),
    ('b5c4d3e2-f1a0-4b9c-8d7e-6f5a4b3c2d1e', 'transfer', 5, 8, 2500.00, 'USD', 'paycheck deposit', 'pending', CURRENT_TIMESTAMP - INTERVAL '36 hours'),
    ('f9e8d7c6-b5a4-4321-bcde-f09876543210', 'withdrawal', 10, NULL, 5000.00, 'USD', 'gift', 'pending', CURRENT_TIMESTAMP - INTERVAL '3 days'),

    -- failed transactions > 1 year old
    ('2a3b4c5d-6e7f-4a5b-8c9d-0e1f2a3b4c5d', 'withdrawal', 2, NULL, 50.00, 'USD', 'insufficient funds', 'failed', CURRENT_TIMESTAMP - INTERVAL '2 years'),
    ('c1d2e3f4-5a6b-4c7d-8e9f-0a1b2c3d4e5f', 'transfer', 7, 9, 210.00, 'USD', 'card expired', 'failed', CURRENT_TIMESTAMP - INTERVAL '18 months'),

    -- pending fee or interest (Fixed invalid UUIDs here)
    ('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'fee', 5, NULL, 15.00, 'USD', 'overdraft fee', 'pending', CURRENT_TIMESTAMP - INTERVAL '1 hour'),
    ('1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d', 'interest', NULL, 11, 0.45, 'USD', 'quarterly interest', 'pending', CURRENT_TIMESTAMP - INTERVAL '1 day'),
    ('a1e2d3f4-b5c6-4e7f-8a9b-0c1d2e3f4a5b', 'fee', 1, NULL, 35.00, 'USD', 'underbalance fee', 'pending', CURRENT_TIMESTAMP - INTERVAL '5 hours'),

    -- the other 21
    ('6a7b8c9d-0e1f-4a2b-3c4d-5e6f7a8b9c0d', 'transfer', 3, 14, 45.50, 'USD', 'dinner', 'completed', CURRENT_TIMESTAMP - INTERVAL '10 minutes'),
    ('f5e4d3c2-b1a0-4f9e-8d7c-6b5a4f3e2d1c', 'withdrawal', 15, NULL, 20.00, 'USD', 'ATM', 'completed', CURRENT_TIMESTAMP - INTERVAL '6 hours'),
    ('3c4d5e6f-7a8b-4c9d-0e1f-2a3b4c5d6e7f', 'deposit', NULL, 2, 1500.00, 'USD', 'paycheck', 'completed', CURRENT_TIMESTAMP - INTERVAL '15 days'),
    ('9b8a7f6e-5d4c-4b3a-2109-87654321fedc', 'transfer', 9, 10, 12.00, 'USD', 'coffee', 'reversed', CURRENT_TIMESTAMP - INTERVAL '4 days'),
    ('7d8c9b0a-1e2f-4a3b-4c5d-6e7f8a9b0c1d', 'withdrawal', 6, NULL, 105.20, 'USD', 'bill', 'completed', CURRENT_TIMESTAMP - INTERVAL '1 month'),
    ('0a1b2c3d-4e5f-4a6b-7c8d-9e0f1a2b3c4d', 'deposit', NULL, 5, 50.00, 'USD', 'gift', 'completed', CURRENT_TIMESTAMP - INTERVAL '1 week'),
    ('5e6f7a8b-9c0d-4e1f-2a3b-4c5d6e7f8a9b', 'fee', 13, NULL, 2.00, 'USD', 'fee', 'completed', CURRENT_TIMESTAMP - INTERVAL '2 months'),
    ('c4d5e6f7-a8b9-4c0d-1e2f-3a4b5c6d7e8f', 'transfer', 11, 4, 300.00, 'USD', 'lunch', 'completed', CURRENT_TIMESTAMP - INTERVAL '12 days'),
    ('1f2a3b4c-5d6e-4f7a-8b9c-0d1e2f3a4b5c', 'interest', NULL, 1, 0.05, 'USD', 'interest', 'completed', CURRENT_TIMESTAMP - INTERVAL '28 days'),
    ('8a9b0c1d-2e3f-4a4b-5c6d-7e8f9a0b1c2d', 'withdrawal', 8, NULL, 85.00, 'USD', 'groceries', 'completed', CURRENT_TIMESTAMP - INTERVAL '4 hours'),
    ('3d2c1b0a-f9e8-4d7c-6b5a-4f3e2d1c0b9a', 'transfer', 12, 1, 1000.00, 'USD', 'mechanic', 'completed', CURRENT_TIMESTAMP - INTERVAL '9 months'),
    ('b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'deposit', NULL, 14, 250.00, 'USD', 'atm', 'completed', CURRENT_TIMESTAMP - INTERVAL '22 hours'),
    ('d1c2b3a4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'withdrawal', 3, NULL, 12.50, 'USD', 'plumber', 'failed', CURRENT_TIMESTAMP - INTERVAL '5 months'),
    ('e4f5a6b7-c8d9-4e0f-1a2b-3c4d5e6f7a8b', 'fee', 10, NULL, 25.00, 'USD', 'fee', 'completed', CURRENT_TIMESTAMP - INTERVAL '3 years'),
    ('7b8c9d0e-1f2a-4b3c-4d5e-6f7a8b9c0d1e', 'transfer', 6, 2, 15.00, 'USD', 'lunch', 'completed', CURRENT_TIMESTAMP - INTERVAL '1 hour'),
    ('9a0b1c2d-3e4f-4a5b-6c7d-8e9f0a1b2c3d', 'interest', NULL, 8, 12.30, 'USD', 'interest', 'completed', CURRENT_TIMESTAMP - INTERVAL '4 months'),
    ('2d1c0b9a-8e7f-4d6c-5b4a-3f2e1d0c9b8a', 'withdrawal', 4, NULL, 99.99, 'USD', 'gas', 'completed', CURRENT_TIMESTAMP - INTERVAL '18 hours'),
    ('7f0b5c1a-8e2d-4b9a-9c3f-1d8e4f5a6b7c', 'deposit', NULL, 13, 3000.00, 'USD', 'paycheck', 'pending', CURRENT_TIMESTAMP - INTERVAL '3 days'),
    ('3d9e8f7a-2b1c-4d5e-8f9a-0b1c2d3e4f5a', 'withdrawal', 1, NULL, 150.00, 'USD', 'withdrawal', 'failed', CURRENT_TIMESTAMP - INTERVAL '3 years'),
    ('a1b2c3d4-e5f6-4a5b-bc6d-7e8f9a0b1c2d', 'transfer', 5, 3, 35.00, 'USD', 'coffee', 'reversed', CURRENT_TIMESTAMP - INTERVAL '2 weeks'),
    ('9e8d7c6b-5a4f-3e2d-1c0b-a9b8c7d6e5f4', 'fee', 14, NULL, 9.99, 'USD', 'overdraw fee', 'completed', CURRENT_TIMESTAMP - INTERVAL '8 days'),
    ('5f4e3d2c-1b0a-9f8e-7d6c-5b4a3f2e1d0c', 'interest', NULL, 6, 1.50, 'USD', 'interest', 'completed', CURRENT_TIMESTAMP - INTERVAL '1 year')
ON CONFLICT (idempotency_key) DO NOTHING;