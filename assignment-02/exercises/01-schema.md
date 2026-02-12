# Exercise 1: Schema Design (DDL)

## Objective

Create the complete database schema for NeoBank, a modern digital banking platform. You will practice:

- `CREATE SCHEMA`
- `CREATE TABLE` with appropriate data types
- Defining constraints: PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, CHECK
- Using different ID strategies: UUID, SERIAL, IDENTITY
- **Writing idempotent DDL that can run multiple times**

## Critical: Your Script Must Be Idempotent

The grading script runs your `01_schema.sql` twice in a row. A failure on the second run costs significant points.

**Idempotent means safe to run multiple times:**

```sql
-- Fails on second run with "schema already exists"
CREATE SCHEMA neobank;

-- Safe to run multiple times
CREATE SCHEMA IF NOT EXISTS neobank;
```

```sql
-- Fails on second run with "table already exists"
CREATE TABLE neobank.customers (id SERIAL PRIMARY KEY);

-- Safe to run multiple times
CREATE TABLE IF NOT EXISTS neobank.customers (id SERIAL PRIMARY KEY);
```

Use `IF NOT EXISTS` for all schema and table creation statements.

## Your Task

Create a file called `sql/01_schema.sql` that creates the following database objects.

---

## 1.1 Create Schema

Create a schema called `neobank` to contain all tables.

Use `IF NOT EXISTS` for idempotency.

```sql
CREATE SCHEMA IF NOT EXISTS neobank;
```

After creating the schema, all subsequent table creations should be prefixed with `neobank.`:

```sql
CREATE TABLE IF NOT EXISTS neobank.customers (
  -- columns here
);
```

---

## 1.2 Table: `neobank.customers`

Create a table to store customer information.

| Column | Data Type | Constraints |
|--------|-----------|-------------|
| `id` | UUID | PRIMARY KEY, default `gen_random_uuid()` |
| `email` | VARCHAR(255) | NOT NULL, UNIQUE |
| `phone_number` | VARCHAR(20) | UNIQUE (can be null) |
| `first_name` | VARCHAR(100) | NOT NULL |
| `last_name` | VARCHAR(100) | NOT NULL |
| `date_of_birth` | DATE | NOT NULL, CHECK: must be at least 18 years old |
| `ssn_hash` | CHAR(64) | NOT NULL, UNIQUE (stores SHA-256 hash) |
| `kyc_status` | VARCHAR(20) | NOT NULL, CHECK: one of 'pending', 'verified', 'rejected', DEFAULT 'pending' |
| `created_at` | TIMESTAMPTZ | DEFAULT CURRENT_TIMESTAMP |
| `updated_at` | TIMESTAMPTZ | DEFAULT CURRENT_TIMESTAMP |

**Hints:**
- For the age CHECK constraint: `date_of_birth <= CURRENT_DATE - INTERVAL '18 years'`
- For the enum-like CHECK: `kyc_status IN ('pending', 'verified', 'rejected')`
- **Don't forget `IF NOT EXISTS`!**

---

## 1.3 Table: `neobank.account_types`

Create a lookup table for different account types offered by the bank.

| Column | Data Type | Constraints |
|--------|-----------|-------------|
| `id` | SERIAL | PRIMARY KEY |
| `name` | VARCHAR(50) | NOT NULL, UNIQUE |
| `description` | TEXT | nullable |
| `interest_rate` | DECIMAL(5,4) | NOT NULL, CHECK: between 0 and 1 |
| `minimum_balance` | DECIMAL(15,2) | NOT NULL, DEFAULT 0.00, CHECK: >= 0 |
| `monthly_fee` | DECIMAL(10,2) | NOT NULL, DEFAULT 0.00, CHECK: >= 0 |
| `is_active` | BOOLEAN | NOT NULL, DEFAULT TRUE |

**Why DECIMAL(5,4)?** This allows values like `0.0450` (4.5% interest rate) with 5 total digits and 4 after the decimal point.

**Why DECIMAL(15,2)?** For monetary values, this allows amounts up to $9,999,999,999,999.99

---

## 1.4 Table: `neobank.accounts`

Create a table to store individual bank accounts.

| Column | Data Type | Constraints |
|--------|-----------|-------------|
| `id` | BIGINT | PRIMARY KEY, GENERATED ALWAYS AS IDENTITY |
| `customer_id` | UUID | NOT NULL, FOREIGN KEY → customers(id) |
| `account_type_id` | INTEGER | NOT NULL, FOREIGN KEY → account_types(id) |
| `account_number` | CHAR(16) | NOT NULL, UNIQUE |
| `routing_number` | CHAR(9) | NOT NULL |
| `balance` | DECIMAL(15,2) | NOT NULL, DEFAULT 0.00 |
| `currency` | CHAR(3) | NOT NULL, DEFAULT 'USD' |
| `status` | VARCHAR(20) | NOT NULL, CHECK: one of 'active', 'frozen', 'closed', DEFAULT 'active' |
| `opened_at` | TIMESTAMPTZ | DEFAULT CURRENT_TIMESTAMP |
| `closed_at` | TIMESTAMPTZ | nullable |

**Advanced CHECK Constraint:** Add a constraint that enforces:
- If `status = 'closed'`, then `closed_at` must NOT be NULL
- If `status != 'closed'`, then `closed_at` must be NULL

```sql
CONSTRAINT chk_accounts_closed_at CHECK (
    (status != 'closed' AND closed_at IS NULL) OR
    (status = 'closed' AND closed_at IS NOT NULL)
)
```

---

## 1.5 Table: `neobank.transactions`

Create a table to store all financial transactions.

| Column | Data Type | Constraints |
|--------|-----------|-------------|
| `id` | UUID | PRIMARY KEY, default `gen_random_uuid()` |
| `idempotency_key` | UUID | NOT NULL, UNIQUE |
| `source_account_id` | BIGINT | FOREIGN KEY → accounts(id), nullable |
| `destination_account_id` | BIGINT | FOREIGN KEY → accounts(id), nullable |
| `transaction_type` | VARCHAR(20) | NOT NULL, CHECK: one of 'deposit', 'withdrawal', 'transfer', 'fee', 'interest' |
| `amount` | DECIMAL(15,2) | NOT NULL, CHECK: > 0 |
| `currency` | CHAR(3) | NOT NULL |
| `description` | VARCHAR(500) | nullable |
| `status` | VARCHAR(20) | NOT NULL, CHECK: one of 'pending', 'completed', 'failed', 'reversed', DEFAULT 'pending' |
| `created_at` | TIMESTAMPTZ | DEFAULT CURRENT_TIMESTAMP |
| `processed_at` | TIMESTAMPTZ | nullable |

**Business Logic CHECK Constraint:** The source and destination accounts depend on transaction type:

| Transaction Type | source_account_id | destination_account_id |
|------------------|-------------------|------------------------|
| deposit | NULL | NOT NULL |
| withdrawal | NOT NULL | NULL |
| fee | NOT NULL | NULL |
| transfer | NOT NULL | NOT NULL |
| interest | NOT NULL | NOT NULL |

Implement this as a CHECK constraint.

---

## 1.6 Table: `neobank.audit_log`

Create a table to track all changes to the database (for compliance).

| Column | Data Type | Constraints |
|--------|-----------|-------------|
| `id` | BIGINT | PRIMARY KEY, GENERATED ALWAYS AS IDENTITY |
| `table_name` | VARCHAR(100) | NOT NULL |
| `record_id` | TEXT | NOT NULL |
| `action` | VARCHAR(10) | NOT NULL, CHECK: one of 'INSERT', 'UPDATE', 'DELETE' |
| `old_values` | JSONB | nullable |
| `new_values` | JSONB | nullable |
| `changed_by` | UUID | nullable |
| `changed_at` | TIMESTAMPTZ | DEFAULT CURRENT_TIMESTAMP |

---

## Verification: The Grading Script

The grading script (`verify.sh`) will test your schema like this:

```bash
# 1. Drop everything to start fresh
docker compose exec -T postgres psql -U postgres -d postgres -c "DROP SCHEMA IF EXISTS neobank CASCADE;"

# 2. Run your schema script FIRST time
docker compose exec -T postgres psql -U postgres -d postgres -f /sql/01_schema.sql
# Expected: SUCCESS

# 3. Run your schema script SECOND time (idempotency test!)
docker compose exec -T postgres psql -U postgres -d postgres -f /sql/01_schema.sql
# Expected: SUCCESS (not an error!)

# 4. Verify schema exists
docker compose exec -T postgres psql -U postgres -d postgres -c "SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'neobank';"
# Expected: 1 row

# 5. Verify all tables exist
docker compose exec -T postgres psql -U postgres -d postgres -c "SELECT table_name FROM information_schema.tables WHERE table_schema = 'neobank' ORDER BY table_name;"
# Expected: account_types, accounts, audit_log, customers, transactions

# 6. Verify specific columns and constraints exist
# ... (additional checks)
```

---

## Quick Idempotency Checklist

Before submitting, verify:

- [ ] `CREATE SCHEMA IF NOT EXISTS neobank;`
- [ ] `CREATE TABLE IF NOT EXISTS neobank.customers (...)`
- [ ] `CREATE TABLE IF NOT EXISTS neobank.account_types (...)`
- [ ] `CREATE TABLE IF NOT EXISTS neobank.accounts (...)`
- [ ] `CREATE TABLE IF NOT EXISTS neobank.transactions (...)`
- [ ] `CREATE TABLE IF NOT EXISTS neobank.audit_log (...)`

Run your script twice to test:

```bash
docker compose exec -T postgres psql -U postgres -d postgres -f /sql/01_schema.sql
docker compose exec -T postgres psql -U postgres -d postgres -f /sql/01_schema.sql  # Must not fail!
```

---

## Deliverable

Create the file `sql/01_schema.sql` with all the CREATE statements. The file should:

1. Create the `neobank` schema using `IF NOT EXISTS`
2. Create all 5 tables using `IF NOT EXISTS`
3. Include all constraints (PK, FK, NOT NULL, UNIQUE, CHECK)
4. Use appropriate ID strategies (UUID, SERIAL, IDENTITY)
5. Be fully idempotent (runnable multiple times without errors)
