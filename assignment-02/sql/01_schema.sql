-- =============================================================================
-- NeoBank Database Schema
-- Assignment 02: SQL Fundamentals - DDL
-- =============================================================================
-- This script should be IDEMPOTENT - it can be run multiple times without errors
-- Tip: Use IF NOT EXISTS for tables and constraints
-- =============================================================================

-- Create schema
CREATE SCHEMA IF NOT EXISTS neobank;

-- =============================================================================
-- Table: customers (UUID as primary key)
-- Requirements:
--   - UUID primary key with auto-generation (gen_random_uuid())
--   - Email: VARCHAR(255), unique, required
--   - Phone number: VARCHAR(20), unique, optional
--   - First name, Last name: VARCHAR(100), required
--   - Date of birth: DATE, required, must be 18+ years old (use CHECK constraint)
--   - SSN hash: CHAR(64), unique, required (for SHA-256 hash)
--   - KYC status: VARCHAR(20), values: 'pending', 'verified', 'rejected' (default: 'pending')
--   - Timestamps: created_at, updated_at (TIMESTAMPTZ with defaults)
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

-- my code
CREATE TABLE IF NOT EXISTS neobank.customers (
    id UUID UNIQUE PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL CHECK (date_of_birth <= CURRENT_DATE - INTERVAL '18 years'), --check this
    ssn_hash CHAR(64) UNIQUE NOT NULL,
    kyc_status VARCHAR(20) CHECK (kyc_status IN ('pending', 'verified', 'rejected')) DEFAULT 'rejected',
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Table: account_types (SERIAL as primary key)
-- Requirements:
--   - SERIAL primary key
--   - Name: VARCHAR(50), unique, required
--   - Description: TEXT, optional
--   - Interest rate: DECIMAL(5,4), required, must be between 0 and 1
--   - Minimum balance: DECIMAL(15,2), required, non-negative, default 0.00
--   - Monthly fee: DECIMAL(10,2), required, non-negative, default 0.00
--   - Is active: BOOLEAN, default TRUE
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

-- my code
CREATE TABLE IF NOT EXISTS neobank.account_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    interest_rate DECIMAL(5,4) NOT NULL CHECK (interest_rate BETWEEN 0 AND 1),
    minimum_balance DECIMAL(15,2) NOT NULL CHECK (minimum_balance >= 0) DEFAULT 0.00,
    monthly_fee DECIMAL(10,2) NOT NULL CHECK (monthly_fee >= 0) DEFAULT 0.00,
    is_active BOOLEAN DEFAULT TRUE
);

-- =============================================================================
-- Table: accounts (IDENTITY as primary key)
-- Requirements:
--   - BIGINT GENERATED ALWAYS AS IDENTITY primary key
--   - Customer ID: UUID, required, foreign key to customers(id) with CASCADE delete
--   - Account type ID: INTEGER, required, foreign key to account_types(id)
--   - Account number: CHAR(16), unique, required
--   - Routing number: CHAR(9), required
--   - Balance: DECIMAL(15,2), required, default 0.00
--   - Currency: CHAR(3), default 'USD'
--   - Status: VARCHAR(20), values: 'active', 'frozen', 'closed' (default: 'active')
--   - Timestamps: opened_at (default), closed_at (nullable)
--   - Constraint: closed_at must be NOT NULL when status is 'closed', NULL otherwise
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

-- my code
CREATE TABLE IF NOT EXISTS neobank.accounts (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id UUID NOT NULL REFERENCES neobank.customers(id) ON DELETE CASCADE,
    account_type_id INTEGER NOT NULL REFERENCES neobank.account_types(id),
    account_number CHAR(16) UNIQUE NOT NULL,
    routing_number CHAR(9) NOT NULL,
    balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    currency CHAR(3) DEFAULT 'USD',
    status VARCHAR(20) CHECK (status IN ('active', 'frozen', 'closed')) DEFAULT 'active',
    opened_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMPTZ CHECK (
        (closed_at IS NOT NULL AND status = 'closed') OR
        (closed_at IS NULL AND status != 'closed')
    )
);

-- =============================================================================
-- Table: transactions (UUID as primary key)
-- Requirements:
--   - UUID primary key with auto-generation
--   - Idempotency key: UUID, unique, required
--   - Source account ID: BIGINT, optional, foreign key to accounts(id)
--   - Destination account ID: BIGINT, optional, foreign key to accounts(id)
--   - Transaction type: VARCHAR(20), values: 'deposit', 'withdrawal', 'transfer', 'fee', 'interest'
--   - Amount: DECIMAL(15,2), required, must be > 0
--   - Currency: CHAR(3), required
--   - Description: TEXT, optional, max 500 characters
--   - Status: VARCHAR(20), values: 'pending', 'completed', 'failed', 'reversed' (default: 'pending')
--   - Timestamps: created_at (default), processed_at (nullable)
--   - Constraint: validate source/destination based on transaction type
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

-- my code
CREATE TABLE IF NOT EXISTS neobank.transactions (
    id UUID UNIQUE PRIMARY KEY DEFAULT gen_random_uuid(),
    idempotency_key UUID UNIQUE NOT NULL,
    source_account_id BIGINT REFERENCES neobank.accounts(id),
    destination_account_id BIGINT REFERENCES neobank.accounts(id),
    transaction_type VARCHAR(20) CHECK (transaction_type IN ('deposit', 'withdrawal', 'transfer', 'fee', 'interest')),
    amount DECIMAL(15,2) NOT NULL CHECK (amount > 0),
    currency CHAR(3) NOT NULL DEFAULT 'USD', -- added default to this so i don't need to specify in seeding transactions
    description TEXT CHECK (char_length(description) < 500),
    status VARCHAR(20) CHECK (status IN ('pending', 'completed', 'failed', 'reversed')) DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    processed_at TIMESTAMPTZ,
    CONSTRAINT transaction_type_validation CHECK (
        (transaction_type = 'deposit' AND destination_account_id IS NOT NULL AND source_account_id IS NULL) OR
        (transaction_type = 'withdrawal' AND destination_account_id IS NULL AND source_account_id IS NOT NULL) OR
        (transaction_type = 'transfer' AND destination_account_id IS NOT NULL AND source_account_id IS NOT NULL) OR
        (transaction_type = 'fee' AND destination_account_id IS NULL AND source_account_id IS NOT NULL) OR
        (transaction_type = 'interest' AND destination_account_id IS NOT NULL AND source_account_id IS NULL)
    )
);

-- =============================================================================
-- Table: audit_log (IDENTITY as primary key)
-- Requirements:
--   - BIGINT GENERATED ALWAYS AS IDENTITY primary key
--   - Table name: VARCHAR(100), required
--   - Record ID: TEXT, required
--   - Old values: JSONB, optional
--   - New values: JSONB, optional
--   - Action: VARCHAR(10), values: 'INSERT', 'UPDATE', 'DELETE'
--   - Changed by: UUID, optional
--   - Changed at: TIMESTAMPTZ with default
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

-- my code
CREATE TABLE IF NOT EXISTS neobank.audit_log (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    record_id TEXT NOT NULL,
    old_values JSONB,
    new_values JSONB,
    action VARCHAR(10) NOT NULL CHECK (action IN ('INSERT', 'UPDATE', 'DELETE')),
    changed_by UUID,
    changed_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Indexes
-- Create indexes to optimize common queries:
--   - customers: email, kyc_status
--   - accounts: customer_id, status
--   - transactions: source_account_id, destination_account_id, status, created_at
-- =============================================================================
-- TODO: Write your CREATE INDEX statements here

-- my code
CREATE INDEX IF NOT EXISTS customers_index ON neobank.customers (email, kyc_status);
CREATE INDEX IF NOT EXISTS accounts_index ON neobank.accounts (customer_id, status);
CREATE INDEX IF NOT EXISTS transactions_index ON neobank.transactions (source_account_id, destination_account_id, status, created_at);