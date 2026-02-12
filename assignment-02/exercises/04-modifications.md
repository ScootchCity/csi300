# Exercise 4: Data Modifications (DML - UPDATE & DELETE)

## Objective

Modify existing data in the NeoBank database using UPDATE and DELETE statements. You will practice:

- `UPDATE ... SET ... WHERE` syntax
- `DELETE FROM ... WHERE` syntax
- Writing precise WHERE clauses to target specific rows
- Understanding the importance of conditions in modification statements
- Handling foreign key constraints during deletion

## Your Task

Create a file called `sql/04_modifications.sql` containing UPDATE and DELETE statements.

---

## Warning: Modifications are Permanent

Unlike SELECT, UPDATE and DELETE change your data permanently. Always:

1. **Test your WHERE clause first** with a SELECT to see which rows will be affected
2. **Consider using transactions** (BEGIN/ROLLBACK) to test before committing
3. **Never run UPDATE or DELETE without a WHERE clause** (unless you want to affect all rows)

```sql
-- GOOD: Specific condition
DELETE FROM neobank.customers WHERE email = 'test@example.com';

-- Affects all rows
DELETE FROM neobank.customers;  -- Deletes all customers
```

---

## Update 1: KYC Batch Rejection

**Goal:** Update all customers with 'pending' KYC status who were created more than 7 days ago to 'rejected' status. Also update their `updated_at` timestamp.

**Table:** `neobank.customers`

**Fields to update:**
- `kyc_status` → 'rejected'
- `updated_at` → CURRENT_TIMESTAMP

**Condition:** `kyc_status = 'pending'` AND `created_at < CURRENT_TIMESTAMP - INTERVAL '7 days'`

**Example structure:**

```sql
UPDATE neobank.customers
SET 
    kyc_status = 'rejected',
    updated_at = CURRENT_TIMESTAMP
WHERE 
    kyc_status = 'pending'
    AND created_at < CURRENT_TIMESTAMP - INTERVAL '7 days';
```

**Test first with SELECT:**

```bash
# See which rows will be affected before running UPDATE
docker compose exec -T postgres psql -U postgres -d postgres -c "
SELECT id, email, kyc_status, created_at
FROM neobank.customers
WHERE kyc_status = 'pending'
  AND created_at < CURRENT_TIMESTAMP - INTERVAL '7 days';
"
```

---

## Update 2: Interest Rate Adjustment

**Goal:** Increase the interest rate of all account types whose name contains 'Savings' by 0.5 percentage points (0.0050). Make sure the rate doesn't exceed 1.0.

**Table:** `neobank.account_types`

**Field to update:** `interest_rate`

**Condition:** `name LIKE '%Savings%'`

**Hint:** Use the `LEAST` function to cap the value at 1.0:

```sql
SET interest_rate = LEAST(interest_rate + 0.0050, 1.0)
```

---

## Update 3: Process Pending Fees

**Goal:** Update all 'pending' transactions of type 'fee' or 'interest' to 'completed' status. Set their `processed_at` to the current timestamp.

**Table:** `neobank.transactions`

**Fields to update:**
- `status` → 'completed'
- `processed_at` → CURRENT_TIMESTAMP

**Condition:** `status = 'pending'` AND `transaction_type IN ('fee', 'interest')`

---

## Update 4: Freeze Low Balance Accounts

**Goal:** Freeze all 'active' accounts that have a balance of $0 or less.

**Table:** `neobank.accounts`

**Field to update:** `status` → 'frozen'

**Condition:** `status = 'active'` AND `balance <= 0`

---

## Update 5: Update Account Balances

**Goal:** Add a $50 bonus to all accounts that:
- Have 'active' status
- Have been opened for more than 90 days
- Have a balance greater than $1,000

**Table:** `neobank.accounts`

**Field to update:** `balance` → `balance + 50.00`

**Condition:** All three conditions above (use AND)

---

## Delete 1: Cleanup Failed Transactions

**Goal:** Delete all transactions with 'failed' status that were created more than 1 year ago.

**Table:** `neobank.transactions`

**Condition:** `status = 'failed'` AND `created_at < CURRENT_TIMESTAMP - INTERVAL '1 year'`

**Always test first:**

```bash
# Count rows to be deleted
docker compose exec -T postgres psql -U postgres -d postgres -c "
SELECT COUNT(*) 
FROM neobank.transactions 
WHERE status = 'failed' 
  AND created_at < CURRENT_TIMESTAMP - INTERVAL '1 year';
"
```

---

## Delete 2: Remove Test Customers

**Goal:** Delete all customers whose email ends with '@test.neobank.local'.

**Challenge:** Due to foreign key constraints, you cannot delete a customer if they have accounts, and you cannot delete accounts if they have transactions.

**You must delete in order:**

1. First, delete transactions for accounts belonging to test customers
2. Then, delete accounts belonging to test customers  
3. Finally, delete the test customers

**Step 1: Delete transactions**

```sql
DELETE FROM neobank.transactions
WHERE source_account_id IN (
    SELECT a.id 
    FROM neobank.accounts a
    WHERE a.customer_id IN (
        SELECT c.id FROM neobank.customers c
        WHERE c.email LIKE '%@test.neobank.local'
    )
)
OR destination_account_id IN (
    SELECT a.id 
    FROM neobank.accounts a
    WHERE a.customer_id IN (
        SELECT c.id FROM neobank.customers c
        WHERE c.email LIKE '%@test.neobank.local'
    )
);
```

**Step 2: Delete accounts**

```sql
DELETE FROM neobank.accounts
WHERE customer_id IN (
    SELECT id FROM neobank.customers
    WHERE email LIKE '%@test.neobank.local'
);
```

**Step 3: Delete customers**

```sql
DELETE FROM neobank.customers
WHERE email LIKE '%@test.neobank.local';
```

---

## Delete 3: Remove Specific Transaction

**Goal:** Delete a specific transaction by its ID. (Use an ID from your seed data)

**Example:**

```sql
DELETE FROM neobank.transactions
WHERE id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx';
```

---

## SQL Syntax Reference

### UPDATE Statement

```sql
UPDATE schema.table_name
SET 
    column1 = new_value1,
    column2 = new_value2
WHERE condition;
```

### DELETE Statement

```sql
DELETE FROM schema.table_name
WHERE condition;
```

### Testing with Transactions

```bash
# Open an interactive psql session
docker compose exec postgres psql -U postgres -d postgres

# Then inside psql:
-- Start a transaction
BEGIN;

-- Run your UPDATE/DELETE
UPDATE neobank.customers SET kyc_status = 'rejected' WHERE ...;

-- Check the results
SELECT * FROM neobank.customers WHERE ...;

-- If something went wrong, undo everything
ROLLBACK;

-- If everything looks good, commit the changes
COMMIT;
```

---

## Verification Queries

After running your modifications, verify the changes:

```bash
# Check KYC status distribution
docker compose exec -T postgres psql -U postgres -d postgres -c "SELECT kyc_status, COUNT(*) FROM neobank.customers GROUP BY kyc_status;"

# Check updated interest rates
docker compose exec -T postgres psql -U postgres -d postgres -c "SELECT name, interest_rate FROM neobank.account_types WHERE name LIKE '%Savings%';"

# Check account statuses
docker compose exec -T postgres psql -U postgres -d postgres -c "SELECT status, COUNT(*) FROM neobank.accounts GROUP BY status;"

# Verify test customers are gone
docker compose exec -T postgres psql -U postgres -d postgres -c "SELECT COUNT(*) FROM neobank.customers WHERE email LIKE '%@test.neobank.local';"
```

---

## Deliverable

Create the file `sql/04_modifications.sql` with:

1. 5 UPDATE statements as specified
2. 3 DELETE statements as specified
3. Comments before each statement explaining what it does
4. Test SELECT statements (commented out) showing how to verify results

**To run your modifications file:**

```bash
docker compose exec -T postgres psql -U postgres -d postgres -f /sql/04_modifications.sql
```
