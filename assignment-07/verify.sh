#!/usr/bin/env bash
set -e
# =============================================================================
# PrecisionParts Mfg - Assignment 07 Verification Script
# =============================================================================
# Verifies student SQL solutions (functions, triggers, transactions)
# Usage:
#   - Local: docker-compose run --rm verify
#   - GitHub Actions: bash ./verify.sh
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

CONTAINER_NAME="${CONTAINER_NAME:-postgres}"
DB_USER="${PGUSER:-postgres}"
DB_NAME="${PGDATABASE:-postgres}"

if [ -n "$PGHOST" ]; then
    RUN_MODE="container"
    DB_HOST="$PGHOST"
    SQL_DIR="/app/sql"
else
    RUN_MODE="host"
    SQL_DIR="./sql"
fi

OUTPUT_DIR="/tmp/output"
TOTAL_POINTS=0
MAX_POINTS=100
BONUS_POINTS=0
MAX_BONUS=20

echo "========================================"
echo "  PrecisionParts Assignment 7 - Verification"
echo "========================================"
echo ""
echo "Note: Drizzle ORM (Exercise 5) is an optional bonus and is not required."
echo ""

mkdir -p "$OUTPUT_DIR"

run_sql() {
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>/dev/null | grep -v '^$' | head -1 | tr -d ' '
    else
        docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>/dev/null | grep -v '^$' | head -1 | tr -d ' '
    fi
}

run_sql_file() {
    local sql_file="$1"
    local output_file="$2"
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -f "$sql_file" > "$output_file" 2>&1
    else
        docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "$sql_file" > "$output_file" 2>&1
    fi
}

print_result() {
    _test_name=$1
    _passed=$2
    _points=$3
    if [ "$_passed" = "true" ]; then
        echo -e "${GREEN}PASS${NC}: $_test_name (+$_points pts)"
        TOTAL_POINTS=$((TOTAL_POINTS + _points))
    else
        echo -e "${RED}FAIL${NC}: $_test_name (0/$_points pts)"
    fi
}

print_bonus_result() {
    _test_name=$1
    _passed=$2
    _points=$3
    if [ "$_passed" = "true" ]; then
        echo -e "${GREEN}BONUS PASS${NC}: $_test_name (+$_points pts)"
        BONUS_POINTS=$((BONUS_POINTS + _points))
    else
        echo -e "${YELLOW}BONUS SKIP${NC}: $_test_name (0/$_points pts)"
    fi
}

run_bonus_cmd() {
    local log_file=$1
    shift
    if [ -z "$DRIZZLE_DIR" ]; then
        return 1
    fi
    pushd "$DRIZZLE_DIR" >/dev/null || return 1
    set +e
    "$@" > "$log_file" 2>&1
    local status=$?
    set -e
    popd >/dev/null || true
    return $status
}

# ============================================
# STEP 1: Check database connection
# ============================================
echo "----------------------------------------"
echo "Step 1: Checking database connection..."
echo "----------------------------------------"

if [ "$RUN_MODE" = "container" ]; then
    if ! psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1" > /dev/null 2>&1; then
        echo -e "${RED}Error: Cannot connect to database.${NC}"
        exit 1
    fi
else
    if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo "Starting PostgreSQL..."
        docker compose down -v --remove-orphans 2>/dev/null || true
        docker compose up -d postgres
        until docker exec "$CONTAINER_NAME" pg_isready -U "$DB_USER" > /dev/null 2>&1; do sleep 1; done
        sleep 2
        until docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1" > /dev/null 2>&1; do sleep 1; done
    fi
fi
echo -e "${GREEN}PASS:${NC} Database connection successful"

PART_COUNT=$(run_sql "SELECT COUNT(*) FROM parts;")
PART_COUNT=${PART_COUNT:-0}
if [ "$PART_COUNT" -lt 1 ]; then
    echo -e "${RED}Error: PrecisionParts schema not initialized properly.${NC}"
    exit 1
fi
echo -e "${GREEN}PASS:${NC} PrecisionParts schema loaded ($PART_COUNT parts)"
echo ""

# ============================================
# STEP 2: Check for required files
# ============================================
echo "----------------------------------------"
echo "Step 2: Checking for required files..."
echo "----------------------------------------"

FILES_MISSING=0
for file in 01-soft-delete 02-functions 03-triggers 04-transactions; do
    if [ -f "$SQL_DIR/$file.sql" ]; then
        echo -e "${GREEN}FOUND${NC}: $file.sql"
    else
        echo -e "${YELLOW}MISSING${NC}: $file.sql"
        FILES_MISSING=$((FILES_MISSING + 1))
    fi
done
echo ""

if [ $FILES_MISSING -eq 4 ]; then
    echo -e "${RED}ERROR: No exercise files found.${NC}"
    exit 1
fi

# ============================================
# STEP 3: Exercise 1 - Soft Delete (25 pts)
# ============================================
echo "----------------------------------------"
echo "Step 3: Exercise 1 - Soft Delete (25 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/01-soft-delete.sql"
EX_OUT="$OUTPUT_DIR/ex1.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 5
    else
        print_result "No SQL errors" "false" 5
    fi

    # Check soft-deleted records exist across tables
    SOFT_DEL=$(run_sql "SELECT COUNT(*) FROM (
        SELECT id FROM employees WHERE deleted_at IS NOT NULL
        UNION ALL SELECT id FROM materials WHERE deleted_at IS NOT NULL
        UNION ALL SELECT id FROM parts WHERE deleted_at IS NOT NULL
        UNION ALL SELECT id FROM machines WHERE deleted_at IS NOT NULL
    ) sub;")
    if [ "${SOFT_DEL:-0}" -ge 4 ] 2>/dev/null; then
        print_result "Soft-deleted records found across tables ($SOFT_DEL total)" "true" 5
    else
        print_result "Soft-deleted records across tables (got ${SOFT_DEL:-0}, expected >= 4)" "false" 5
    fi

    # Check specific soft-delete: a material should be soft-deleted
    MAT_DEL=$(run_sql "SELECT COUNT(*) FROM materials WHERE deleted_at IS NOT NULL;")
    if [ "${MAT_DEL:-0}" -ge 1 ] 2>/dev/null; then
        print_result "At least 1 material soft-deleted ($MAT_DEL found)" "true" 5
    else
        print_result "At least 1 material soft-deleted (got ${MAT_DEL:-0})" "false" 5
    fi

    # Check restore: employee EMP029 should be active again
    EMP029=$(run_sql "SELECT COUNT(*) FROM employees WHERE employee_number = 'EMP029' AND deleted_at IS NULL AND is_active = true;")
    if [ "${EMP029:-0}" = "1" ]; then
        print_result "Employee EMP029 restored (active, no deleted_at)" "true" 5
    else
        print_result "Employee EMP029 restored (got ${EMP029:-0})" "false" 5
    fi

    # Check machine soft-delete
    MACH_DEL=$(run_sql "SELECT COUNT(*) FROM machines WHERE deleted_at IS NOT NULL;")
    if [ "${MACH_DEL:-0}" -ge 1 ] 2>/dev/null; then
        print_result "At least 1 machine soft-deleted ($MACH_DEL found)" "true" 5
    else
        print_result "Machine soft-deleted (got ${MACH_DEL:-0})" "false" 5
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 1 - File not found (0/25 pts)"
fi
echo ""

# ============================================
# STEP 4: Exercise 2 - Functions (25 pts)
# ============================================
echo "----------------------------------------"
echo "Step 4: Exercise 2 - Functions (25 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/02-functions.sql"
EX_OUT="$OUTPUT_DIR/ex2.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 5
    else
        print_result "No SQL errors" "false" 5
    fi

    # Check calculate_material_value function
    FN1=$(run_sql "SELECT COUNT(*) FROM pg_proc WHERE proname = 'calculate_material_value';")
    if [ "${FN1:-0}" -ge 1 ] 2>/dev/null; then
        print_result "Function calculate_material_value exists" "true" 5
    else
        print_result "Function calculate_material_value exists" "false" 5
    fi

    # Check get_run_duration_hours function
    FN2=$(run_sql "SELECT COUNT(*) FROM pg_proc WHERE proname = 'get_run_duration_hours';")
    if [ "${FN2:-0}" -ge 1 ] 2>/dev/null; then
        print_result "Function get_run_duration_hours exists" "true" 5
    else
        print_result "Function get_run_duration_hours exists" "false" 5
    fi

    # Check estimate_part_cost function
    FN3=$(run_sql "SELECT COUNT(*) FROM pg_proc WHERE proname = 'estimate_part_cost';")
    if [ "${FN3:-0}" -ge 1 ] 2>/dev/null; then
        print_result "Function estimate_part_cost exists" "true" 5
    else
        print_result "Function estimate_part_cost exists" "false" 5
    fi

    # Check get_part_quality_rate OR generate_part_number function
    FN4=$(run_sql "SELECT COUNT(*) FROM pg_proc WHERE proname IN ('get_part_quality_rate', 'generate_part_number');")
    if [ "${FN4:-0}" -ge 1 ] 2>/dev/null; then
        print_result "Function get_part_quality_rate or generate_part_number exists" "true" 5
    else
        print_result "Function get_part_quality_rate or generate_part_number exists" "false" 5
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 2 - File not found (0/25 pts)"
fi
echo ""

# ============================================
# STEP 5: Exercise 3 - Triggers (25 pts)
# ============================================
echo "----------------------------------------"
echo "Step 5: Exercise 3 - Triggers (25 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/03-triggers.sql"
EX_OUT="$OUTPUT_DIR/ex3.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 5
    else
        print_result "No SQL errors" "false" 5
    fi

    # Check for audit trigger on parts
    TRIG1=$(run_sql "SELECT COUNT(*) FROM pg_trigger t JOIN pg_class c ON t.tgrelid = c.oid WHERE NOT t.tgisinternal AND (t.tgname LIKE '%audit%' OR t.tgname LIKE '%parts_audit%' OR t.tgname LIKE '%log%part%') AND c.relname = 'parts';")
    if [ "${TRIG1:-0}" -ge 1 ] 2>/dev/null; then
        print_result "Audit trigger on parts table" "true" 5
    else
        print_result "Audit trigger on parts table" "false" 5
    fi

    # Check for inventory trigger
    TRIG2=$(run_sql "SELECT COUNT(*) FROM pg_trigger t JOIN pg_class c ON t.tgrelid = c.oid WHERE NOT t.tgisinternal AND (t.tgname LIKE '%inventory%' OR t.tgname LIKE '%log_inv%' OR t.tgname LIKE '%stock%');")
    if [ "${TRIG2:-0}" -ge 1 ] 2>/dev/null; then
        print_result "Inventory tracking trigger" "true" 5
    else
        print_result "Inventory tracking trigger" "false" 5
    fi

    # Check for order status trigger
    TRIG3=$(run_sql "SELECT COUNT(*) FROM pg_trigger t JOIN pg_class c ON t.tgrelid = c.oid WHERE NOT t.tgisinternal AND (t.tgname LIKE '%order%status%' OR t.tgname LIKE '%status%change%' OR t.tgname LIKE '%order%update%');")
    if [ "${TRIG3:-0}" -ge 1 ] 2>/dev/null; then
        print_result "Order status change trigger" "true" 5
    else
        print_result "Order status change trigger" "false" 5
    fi

    # Check for prevent-delete or timestamp trigger
    TRIG4=$(run_sql "SELECT COUNT(*) FROM pg_trigger t JOIN pg_class c ON t.tgrelid = c.oid WHERE NOT t.tgisinternal AND (t.tgname LIKE '%prevent%' OR t.tgname LIKE '%protect%' OR t.tgname LIKE '%timestamp%' OR t.tgname LIKE '%updated_at%');")
    if [ "${TRIG4:-0}" -ge 1 ] 2>/dev/null; then
        print_result "Prevent-delete or timestamp trigger" "true" 5
    else
        print_result "Prevent-delete or timestamp trigger" "false" 5
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 3 - File not found (0/25 pts)"
fi
echo ""

# ============================================
# STEP 6: Exercise 4 - Transactions (25 pts)
# ============================================
echo "----------------------------------------"
echo "Step 6: Exercise 4 - Transactions (25 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/04-transactions.sql"
EX_OUT="$OUTPUT_DIR/ex4.txt"
if [ -f "$EX_FILE" ]; then
    # Clean up potential test data from previous runs
    run_sql "DELETE FROM order_items WHERE production_order_id IN (SELECT id FROM production_orders WHERE order_number = 'PO-2024-100');" 2>/dev/null || true
    run_sql "DELETE FROM production_orders WHERE order_number = 'PO-2024-100';" 2>/dev/null || true

    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    # For transactions, some ERRORs are expected (from rollback demonstrations)
    # Only check for critical syntax errors
    CRITICAL_ERRS=$(grep -cE "^ERROR:.*(syntax error|does not exist)" "$EX_OUT" 2>/dev/null) || CRITICAL_ERRS=0
    if [ "$CRITICAL_ERRS" -eq 0 ]; then
        print_result "No critical SQL errors" "true" 5
    else
        print_result "No critical SQL errors ($CRITICAL_ERRS found)" "false" 5
    fi

    # Check that production order PO-2024-100 was created
    PO100=$(run_sql "SELECT COUNT(*) FROM production_orders WHERE order_number = 'PO-2024-100';")
    if [ "${PO100:-0}" = "1" ]; then
        print_result "Production order PO-2024-100 created" "true" 5
    else
        print_result "Production order PO-2024-100 (got ${PO100:-0}, expected 1)" "false" 5
    fi

    # Check that order items were created for PO-2024-100
    OI_COUNT=$(run_sql "SELECT COUNT(*) FROM order_items oi JOIN production_orders po ON oi.order_id = po.id WHERE po.order_number = 'PO-2024-100';")
    if [ "${OI_COUNT:-0}" -ge 2 ] 2>/dev/null; then
        print_result "Order items for PO-2024-100 ($OI_COUNT items)" "true" 5
    else
        print_result "Order items for PO-2024-100 (got ${OI_COUNT:-0}, expected >= 2)" "false" 5
    fi

    # Check production run status update
    RUN12=$(run_sql "SELECT status FROM production_runs WHERE id = 12;")
    if [ "$RUN12" = "completed" ]; then
        print_result "Production run 12 status = completed" "true" 5
    else
        print_result "Production run 12 status (got '${RUN12:-empty}', expected 'completed')" "false" 5
    fi

    # Check inventory transfer logs
    TRANSFERS=$(run_sql "SELECT COUNT(*) FROM inventory_log WHERE change_type = 'transferred';")
    if [ "${TRANSFERS:-0}" -ge 2 ] 2>/dev/null; then
        print_result "Inventory transfers logged ($TRANSFERS records)" "true" 5
    else
        print_result "Inventory transfers (got ${TRANSFERS:-0}, expected >= 2)" "false" 5
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 4 - File not found (0/25 pts)"
fi
echo ""

# ============================================
# STEP 7: Bonus Exercise 5 - Drizzle ORM (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 7: Bonus Exercise 5 - Drizzle ORM (20 pts)"
echo "----------------------------------------"

if [ -d "/app" ]; then
    BASE_DIR="/app"
else
    BASE_DIR="."
fi

DRIZZLE_DIR="$BASE_DIR/drizzle"
PACKAGE_JSON="$DRIZZLE_DIR/package.json"
NODE_MODULES_DIR="$DRIZZLE_DIR/node_modules"

if [ -f "$PACKAGE_JSON" ]; then
    if ! command -v npm >/dev/null 2>&1; then
        echo -e "${YELLOW}BONUS SKIP${NC}: npm not available (0/20 pts)"
    else
        INSTALL_OK=true
        if [ ! -d "$NODE_MODULES_DIR" ]; then
            INSTALL_LOG="$OUTPUT_DIR/drizzle_install.txt"
            echo "Installing Drizzle dependencies..."
            if ! run_bonus_cmd "$INSTALL_LOG" npm install; then
                echo -e "${YELLOW}BONUS SKIP${NC}: Drizzle dependencies install failed (0/20 pts)"
                echo -e "${YELLOW}BONUS SKIP${NC}: Check $INSTALL_LOG for details"
                INSTALL_OK=false
            fi
        fi

        if [ "$INSTALL_OK" = "true" ]; then
            CONN_LOG="$OUTPUT_DIR/drizzle_connection.txt"
            if run_bonus_cmd "$CONN_LOG" npm run test:connection; then
                print_bonus_result "Drizzle connection test" "true" 0

            CRUD_LOG="$OUTPUT_DIR/drizzle_crud.txt"
            if run_bonus_cmd "$CRUD_LOG" npm run test:crud; then
                print_bonus_result "5.1 CRUD tests" "true" 4
            else
                print_bonus_result "5.1 CRUD tests" "false" 4
            fi

            FILTERS_LOG="$OUTPUT_DIR/drizzle_filters.txt"
            if run_bonus_cmd "$FILTERS_LOG" npm run test:filters; then
                print_bonus_result "5.2 Filter tests" "true" 4
            else
                print_bonus_result "5.2 Filter tests" "false" 4
            fi

            JOINS_LOG="$OUTPUT_DIR/drizzle_joins.txt"
            if run_bonus_cmd "$JOINS_LOG" npm run test:joins; then
                print_bonus_result "5.3 Joins tests" "true" 5
            else
                print_bonus_result "5.3 Joins tests" "false" 5
            fi

            AGG_LOG="$OUTPUT_DIR/drizzle_aggregation.txt"
            if run_bonus_cmd "$AGG_LOG" npm run test:aggregation; then
                print_bonus_result "5.4 Aggregation tests" "true" 4
            else
                print_bonus_result "5.4 Aggregation tests" "false" 4
            fi

            TX_LOG="$OUTPUT_DIR/drizzle_transactions.txt"
            if run_bonus_cmd "$TX_LOG" npm run test:transactions; then
                print_bonus_result "5.5 Transaction tests" "true" 3
            else
                print_bonus_result "5.5 Transaction tests" "false" 3
            fi
            else
                print_bonus_result "Drizzle connection test" "false" 0
                echo -e "${YELLOW}BONUS SKIP${NC}: Drizzle tests skipped due to connection failure"
            fi
        fi
    fi
else
    echo -e "${YELLOW}BONUS SKIP${NC}: Drizzle package.json not found (0/20 pts)"
fi
echo ""

# ============================================
# FINAL SCORE
# ============================================
echo "========================================"
echo "           FINAL SCORE"
echo "========================================"
echo ""
echo -e "Total Points (required): ${GREEN}$TOTAL_POINTS${NC} / $MAX_POINTS"
echo -e "Bonus Points: ${GREEN}$BONUS_POINTS${NC} / $MAX_BONUS"
echo -e "Overall: ${GREEN}$((TOTAL_POINTS + BONUS_POINTS))${NC} / $((MAX_POINTS + MAX_BONUS))"
echo ""

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

rm -rf "$OUTPUT_DIR"
