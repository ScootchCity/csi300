#!/usr/bin/env bash
set -e

# NeoBank Assignment 2 - Automated Verification Script
# This script tests student submissions for correctness and idempotency
# 
# Usage:
#   - Local (Windows/Mac/Linux): docker-compose run --rm verify
#   - GitHub Actions: bash ./verify.sh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
CONTAINER_NAME="${CONTAINER_NAME:-postgres}"
DB_USER="${PGUSER:-postgres}"
DB_NAME="${PGDATABASE:-postgres}"

# Detect if running inside container or on host
if [ -n "$PGHOST" ]; then
    # Running inside container (docker-compose run verify)
    RUN_MODE="container"
    DB_HOST="$PGHOST"
    SQL_DIR="/sql"
else
    # Running on host (GitHub Actions or local bash)
    RUN_MODE="host"
    SQL_DIR="./sql"
fi

# Score tracking
TOTAL_POINTS=0
MAX_POINTS=100

echo "========================================"
echo "  NeoBank Assignment 2 - Verification"
echo "========================================"
echo ""

# Function to run SQL and capture result
run_sql() {
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>&1
    else
        docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>&1
    fi
}

# Function to run SQL file
run_sql_file() {
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" < "$1" 2>&1
    else
        docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "$1" 2>&1
    fi
}

# Function to print test result
print_result() {
    local test_name=$1
    local passed=$2
    local points=$3
    
    if [ "$passed" = true ]; then
        echo -e "${GREEN}PASS${NC}: $test_name (+$points pts)"
        TOTAL_POINTS=$((TOTAL_POINTS + points))
    else
        echo -e "${RED}FAIL${NC}: $test_name (0/$points pts)"
    fi
}

# Check if SQL files exist
echo "Checking for required files..."
echo ""

SCHEMA_FILE="$SQL_DIR/01_schema.sql"
SEED_FILE="$SQL_DIR/02_seed.sql"
QUERIES_FILE="$SQL_DIR/03_queries.sql"
MODIFICATIONS_FILE="$SQL_DIR/04_modifications.sql"

if [ ! -f "$SCHEMA_FILE" ]; then
    echo -e "${RED}ERROR: $SCHEMA_FILE not found${NC}"
    exit 1
fi

if [ ! -f "$SEED_FILE" ]; then
    echo -e "${RED}ERROR: $SEED_FILE not found${NC}"
    exit 1
fi

echo -e "${GREEN}PASS:${NC} Found: 01_schema.sql"
echo -e "${GREEN}PASS:${NC} Found: 02_seed.sql"
[ -f "$QUERIES_FILE" ] && echo -e "${GREEN}PASS:${NC} Found: 03_queries.sql" || echo -e "${YELLOW}⚠${NC} Optional: 03_queries.sql not found"
[ -f "$MODIFICATIONS_FILE" ] && echo -e "${GREEN}PASS:${NC} Found: 04_modifications.sql" || echo -e "${YELLOW}⚠${NC} Optional: 04_modifications.sql not found"
echo ""

# ============================================
# STEP 0: Ensure database is running
# ============================================
if [ "$RUN_MODE" = "host" ]; then
    if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo "Starting PostgreSQL via docker compose..."
        docker compose down -v --remove-orphans 2>/dev/null || true
        docker compose up -d postgres
        echo "Waiting for PostgreSQL to be ready..."
        until docker exec "$CONTAINER_NAME" pg_isready -U "$DB_USER" > /dev/null 2>&1; do
            sleep 1
        done
    fi
fi

# ============================================
# STEP 1: Clean slate - drop the schema
# ============================================
echo "----------------------------------------"
echo "Step 1: Preparing clean environment..."
echo "----------------------------------------"

run_sql "DROP SCHEMA IF EXISTS neobank CASCADE;" > /dev/null 2>&1
echo "Dropped existing neobank schema (if any)"
echo ""

# ============================================
# STEP 2: Run schema.sql FIRST TIME
# ============================================
echo "----------------------------------------"
echo "Step 2: Running schema.sql (first time)"
echo "----------------------------------------"

OUTPUT=$(run_sql_file "$SCHEMA_FILE" 2>&1)
RESULT=$?

if [ $RESULT -eq 0 ]; then
    echo -e "${GREEN}PASS:${NC} Schema created successfully on first run"
    print_result "Schema executes without errors (first run)" true 10
else
    echo -e "${RED}FAIL:${NC} Schema failed on first run:"
    echo "$OUTPUT"
    print_result "Schema executes without errors (first run)" false 10
    echo ""
    echo "FATAL: Cannot continue without a working schema."
    exit 1
fi
echo ""

# ============================================
# STEP 3: Run schema.sql SECOND TIME (idempotency test)
# ============================================
echo "----------------------------------------"
echo "Step 3: Running schema.sql (SECOND time)"
echo "        Testing IDEMPOTENCY..."
echo "----------------------------------------"

OUTPUT=$(run_sql_file "$SCHEMA_FILE" 2>&1)
RESULT=$?

if [ $RESULT -eq 0 ]; then
    echo -e "${GREEN}PASS:${NC} Schema is IDEMPOTENT - runs twice without errors!"
    print_result "Schema is idempotent (runs twice)" true 15
else
    echo -e "${RED}FAIL:${NC} Schema is NOT IDEMPOTENT - failed on second run!"
    echo "   This usually means you forgot 'IF NOT EXISTS' somewhere."
    echo ""
    echo "Error output:"
    echo "$OUTPUT"
    print_result "Schema is idempotent (runs twice)" false 15
fi
echo ""

# ============================================
# STEP 4: Verify required database objects
# ============================================
echo "----------------------------------------"
echo "Step 4: Verifying database objects..."
echo "----------------------------------------"

# Check schema exists
SCHEMA_EXISTS=$(run_sql "SELECT COUNT(*) FROM information_schema.schemata WHERE schema_name = 'neobank';")
if [ "$(echo $SCHEMA_EXISTS | tr -d ' ')" = "1" ]; then
    print_result "Schema 'neobank' exists" true 7
else
    print_result "Schema 'neobank' exists" false 7
fi

# Check required tables
REQUIRED_TABLES=("customers" "account_types" "accounts" "transactions" "audit_log")

for table in "${REQUIRED_TABLES[@]}"; do
    TABLE_EXISTS=$(run_sql "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'neobank' AND table_name = '$table';")
    if [ "$(echo $TABLE_EXISTS | tr -d ' ')" = "1" ]; then
        print_result "Table 'neobank.$table' exists" true 2
    else
        print_result "Table 'neobank.$table' exists" false 2
    fi
done
echo ""

# ============================================
# STEP 5: Check column constraints (sample checks)
# ============================================
echo "----------------------------------------"
echo "Step 5: Checking column definitions..."
echo "----------------------------------------"

# Check customers.id is UUID
CUSTOMERS_ID_TYPE=$(run_sql "SELECT data_type FROM information_schema.columns WHERE table_schema = 'neobank' AND table_name = 'customers' AND column_name = 'id';")
if [ "$(echo $CUSTOMERS_ID_TYPE | tr -d ' ')" = "uuid" ]; then
    print_result "customers.id is UUID type" true 2
else
    print_result "customers.id is UUID type" false 2
fi

# Check accounts has IDENTITY or SERIAL
# Note: GENERATED ALWAYS AS IDENTITY uses is_identity='YES', SERIAL uses nextval in column_default
ACCOUNTS_ID_IDENTITY=$(run_sql "SELECT is_identity FROM information_schema.columns WHERE table_schema = 'neobank' AND table_name = 'accounts' AND column_name = 'id';")
ACCOUNTS_ID_DEFAULT=$(run_sql "SELECT column_default FROM information_schema.columns WHERE table_schema = 'neobank' AND table_name = 'accounts' AND column_name = 'id';")
if [[ "$(echo $ACCOUNTS_ID_IDENTITY | tr -d ' ')" == "YES" ]] || [[ "$ACCOUNTS_ID_DEFAULT" == *"nextval"* ]]; then
    print_result "accounts.id uses IDENTITY/SERIAL" true 2
else
    print_result "accounts.id uses IDENTITY/SERIAL" false 2
fi

# Check account_types has SERIAL or IDENTITY
ACCOUNT_TYPES_ID_IDENTITY=$(run_sql "SELECT is_identity FROM information_schema.columns WHERE table_schema = 'neobank' AND table_name = 'account_types' AND column_name = 'id';")
ACCOUNT_TYPES_ID=$(run_sql "SELECT column_default FROM information_schema.columns WHERE table_schema = 'neobank' AND table_name = 'account_types' AND column_name = 'id';")
if [[ "$(echo $ACCOUNT_TYPES_ID_IDENTITY | tr -d ' ')" == "YES" ]] || [[ "$ACCOUNT_TYPES_ID" == *"nextval"* ]]; then
    print_result "account_types.id uses SERIAL/IDENTITY" true 2
else
    print_result "account_types.id uses SERIAL/IDENTITY" false 2
fi
echo ""

# ============================================
# STEP 6: Run seed data
# ============================================
echo "----------------------------------------"
echo "Step 6: Running seed data..."
echo "----------------------------------------"

OUTPUT=$(run_sql_file "$SEED_FILE" 2>&1)
RESULT=$?

if [ $RESULT -eq 0 ]; then
    echo -e "${GREEN}PASS:${NC} Seed data inserted successfully"
    print_result "Seed data executes without errors" true 10
else
    echo -e "${RED}FAIL:${NC} Seed data failed:"
    echo "$OUTPUT"
    print_result "Seed data executes without errors" false 10
fi
echo ""

# ============================================
# STEP 7: Verify data counts
# ============================================
echo "----------------------------------------"
echo "Step 7: Verifying data requirements..."
echo "----------------------------------------"

# Check account_types count
ACCOUNT_TYPES_COUNT=$(run_sql "SELECT COUNT(*) FROM neobank.account_types;")
if [ "$(echo $ACCOUNT_TYPES_COUNT | tr -d ' ')" -ge "5" ]; then
    print_result "At least 5 account types exist" true 3
else
    print_result "At least 5 account types exist" false 3
fi

# Check customers count
CUSTOMERS_COUNT=$(run_sql "SELECT COUNT(*) FROM neobank.customers;")
if [ "$(echo $CUSTOMERS_COUNT | tr -d ' ')" -ge "10" ]; then
    print_result "At least 10 customers exist" true 5
else
    print_result "At least 10 customers exist (found: $CUSTOMERS_COUNT)" false 5
fi

# Check accounts count
ACCOUNTS_COUNT=$(run_sql "SELECT COUNT(*) FROM neobank.accounts;")
if [ "$(echo $ACCOUNTS_COUNT | tr -d ' ')" -ge "15" ]; then
    print_result "At least 15 accounts exist" true 5
else
    print_result "At least 15 accounts exist (found: $ACCOUNTS_COUNT)" false 5
fi

# Check transactions count
TRANSACTIONS_COUNT=$(run_sql "SELECT COUNT(*) FROM neobank.transactions;")
if [ "$(echo $TRANSACTIONS_COUNT | tr -d ' ')" -ge "30" ]; then
    print_result "At least 30 transactions exist" true 5
else
    print_result "At least 30 transactions exist (found: $TRANSACTIONS_COUNT)" false 5
fi
echo ""

# ============================================
# STEP 8: Run seed data SECOND TIME (idempotency)
# ============================================
echo "----------------------------------------"
echo "Step 8: Running seed data (SECOND time)"
echo "        Testing seed IDEMPOTENCY..."
echo "----------------------------------------"

OUTPUT=$(run_sql_file "$SEED_FILE" 2>&1)
RESULT=$?

if [ $RESULT -eq 0 ]; then
    echo -e "${GREEN}PASS:${NC} Seed data is IDEMPOTENT!"
    print_result "Seed data is idempotent (ON CONFLICT used)" true 10
else
    echo -e "${RED}FAIL:${NC} Seed data failed on second run!"
    echo "   Use 'ON CONFLICT DO NOTHING' for idempotent inserts."
    echo ""
    echo "Error output:"
    echo "$OUTPUT"
    print_result "Seed data is idempotent (ON CONFLICT used)" false 10
fi
echo ""

# ============================================
# STEP 9: Check specific data requirements
# ============================================
echo "----------------------------------------"
echo "Step 9: Checking specific data cases..."
echo "----------------------------------------"

# Check for test customer
TEST_CUSTOMER=$(run_sql "SELECT COUNT(*) FROM neobank.customers WHERE email LIKE '%@test.neobank.local';")
if [ "$(echo $TEST_CUSTOMER | tr -d ' ')" -ge "1" ]; then
    print_result "Test customer with @test.neobank.local exists" true 3
else
    print_result "Test customer with @test.neobank.local exists" false 3
fi

# Check for frozen account
FROZEN_ACCOUNT=$(run_sql "SELECT COUNT(*) FROM neobank.accounts WHERE status = 'frozen';")
if [ "$(echo $FROZEN_ACCOUNT | tr -d ' ')" -ge "1" ]; then
    print_result "At least one frozen account exists" true 3
else
    print_result "At least one frozen account exists" false 3
fi

# Check for high-balance account
HIGH_BALANCE=$(run_sql "SELECT COUNT(*) FROM neobank.accounts WHERE balance > 25000;")
if [ "$(echo $HIGH_BALANCE | tr -d ' ')" -ge "1" ]; then
    print_result "At least one account with balance > 25000" true 3
else
    print_result "At least one account with balance > 25000" false 3
fi

# Check for pending old transactions
PENDING_OLD=$(run_sql "SELECT COUNT(*) FROM neobank.transactions WHERE status = 'pending' AND created_at < NOW() - INTERVAL '24 hours' AND amount > 1000;")
if [ "$(echo $PENDING_OLD | tr -d ' ')" -ge "3" ]; then
    print_result "At least 3 pending transactions > 1000 older than 24h" true 5
else
    print_result "At least 3 pending transactions > 1000 older than 24h" false 5
fi
echo ""

# ============================================
# FINAL SCORE
# ============================================
echo "========================================"
echo "           FINAL SCORE"
echo "========================================"
echo ""
echo -e "Total Points: ${GREEN}$TOTAL_POINTS${NC} / $MAX_POINTS"
echo ""

# Grade calculation
if [ $TOTAL_POINTS -ge 90 ]; then
    echo -e "Grade: ${GREEN}A${NC}"
elif [ $TOTAL_POINTS -ge 80 ]; then
    echo -e "Grade: ${GREEN}B${NC}"
elif [ $TOTAL_POINTS -ge 70 ]; then
    echo -e "Grade: ${YELLOW}C${NC}"
elif [ $TOTAL_POINTS -ge 60 ]; then
    echo -e "Grade: ${YELLOW}D${NC}"
else
    echo -e "Grade: ${RED}F${NC}"
fi

echo ""
echo "========================================"
