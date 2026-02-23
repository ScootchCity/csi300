#!/usr/bin/env bash
set -e
# =============================================================================
# MedCare Health Clinic - Assignment 05 Verification Script
# =============================================================================
# Verifies student SQL Join solutions using specific query-based checks
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

echo "========================================"
echo "  MedCare Clinic Assignment 5 - Verification"
echo "========================================"
echo ""

mkdir -p "$OUTPUT_DIR"

# Run SQL query, return trimmed single value
run_sql() {
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>/dev/null | grep -v '^$' | head -1 | tr -d ' '
    else
        docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>/dev/null | grep -v '^$' | head -1 | tr -d ' '
    fi
}

# Run SQL file, capture output
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

# Get Nth row count from psql output (matches "(N rows)" or "(1 row)")
get_row_count() {
    sed -n 's/.*(\([0-9][0-9]*\) rows\{0,1\}).*/\1/p' "$1" | sed -n "${2}p"
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

# Verify database tables
PATIENT_COUNT=$(run_sql "SELECT COUNT(*) FROM patients;")
PATIENT_COUNT=${PATIENT_COUNT:-0}
if [ "$PATIENT_COUNT" -lt 1 ]; then
    echo -e "${RED}Error: MedCare database not initialized properly.${NC}"
    exit 1
fi
echo -e "${GREEN}PASS:${NC} MedCare database loaded ($PATIENT_COUNT patients)"
echo ""

# ============================================
# STEP 2: Check for required files
# ============================================
echo "----------------------------------------"
echo "Step 2: Checking for required files..."
echo "----------------------------------------"

FILES_MISSING=0
for file in 01-inner-joins 02-left-joins 03-right-full-joins 04-self-joins 05-multi-table-joins; do
    if [ -f "$SQL_DIR/$file.sql" ]; then
        echo -e "${GREEN}FOUND${NC}: $file.sql"
    else
        echo -e "${YELLOW}MISSING${NC}: $file.sql"
        FILES_MISSING=$((FILES_MISSING + 1))
    fi
done
echo ""

if [ $FILES_MISSING -eq 5 ]; then
    echo -e "${RED}ERROR: No exercise files found.${NC}"
    exit 1
fi

# Pre-compute expected values from database
COMPLETED_APPTS=$(run_sql "SELECT COUNT(*) FROM appointments WHERE status = 'completed';")
ACTIVE_DOCTORS=$(run_sql "SELECT COUNT(*) FROM doctors WHERE is_active = true;")
ALL_DOCTORS=$(run_sql "SELECT COUNT(*) FROM doctors;")
UNINSURED=$(run_sql "SELECT COUNT(*) FROM patients WHERE insurance_id IS NULL;")
ALL_PATIENTS=$(run_sql "SELECT COUNT(*) FROM patients;")
ALL_DEPTS=$(run_sql "SELECT COUNT(*) FROM departments;")
ALL_PROVIDERS=$(run_sql "SELECT COUNT(*) FROM insurance_providers;")

# ============================================
# STEP 3: Exercise 1 - Inner Joins (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 3: Exercise 1 - Inner Joins (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/01-inner-joins.sql"
EX_OUT="$OUTPUT_DIR/ex1.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    QC=$(grep -c "rows\{0,1\})" "$EX_OUT" 2>/dev/null) || QC=0
    if [ "$QC" -ge 5 ]; then
        print_result "All 5 queries present" "true" 4
    else
        print_result "All 5 queries present ($QC found)" "false" 4
    fi

    R1=$(get_row_count "$EX_OUT" 1)
    if [ "${R1:-0}" = "$COMPLETED_APPTS" ]; then
        print_result "1.1 Completed appointments ($R1 rows)" "true" 4
    else
        print_result "1.1 Completed appointments (got ${R1:-0}, expected $COMPLETED_APPTS)" "false" 4
    fi

    R2=$(get_row_count "$EX_OUT" 2)
    if [ "${R2:-0}" = "$ACTIVE_DOCTORS" ]; then
        print_result "1.2 Active doctors with departments ($R2 rows)" "true" 4
    else
        print_result "1.2 Active doctors (got ${R2:-0}, expected $ACTIVE_DOCTORS)" "false" 4
    fi

    R3=$(get_row_count "$EX_OUT" 3)
    if [ -n "$R3" ] && [ "$R3" -gt 0 ] 2>/dev/null; then
        print_result "1.3 Doctor specializations ($R3 rows)" "true" 4
    else
        print_result "1.3 Doctor specializations (empty result)" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 1 - File not found (0/20 pts)"
fi
echo ""

# ============================================
# STEP 4: Exercise 2 - Left Joins (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 4: Exercise 2 - Left Joins (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/02-left-joins.sql"
EX_OUT="$OUTPUT_DIR/ex2.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    QC=$(grep -c "rows\{0,1\})" "$EX_OUT" 2>/dev/null) || QC=0
    if [ "$QC" -ge 5 ]; then
        print_result "All 5 queries present" "true" 4
    else
        print_result "All 5 queries present ($QC found)" "false" 4
    fi

    R1=$(get_row_count "$EX_OUT" 1)
    if [ "${R1:-0}" = "$UNINSURED" ]; then
        print_result "2.1 Patients without insurance ($R1 rows)" "true" 4
    else
        print_result "2.1 Patients without insurance (got ${R1:-0}, expected $UNINSURED)" "false" 4
    fi

    R4=$(get_row_count "$EX_OUT" 4)
    if [ "${R4:-0}" = "$ALL_PATIENTS" ]; then
        print_result "2.4 All patients with insurance status ($R4 rows)" "true" 4
    else
        print_result "2.4 All patients (got ${R4:-0}, expected $ALL_PATIENTS)" "false" 4
    fi

    R2=$(get_row_count "$EX_OUT" 2)
    R3=$(get_row_count "$EX_OUT" 3)
    R5=$(get_row_count "$EX_OUT" 5)
    NON_EMPTY=0
    [ -n "$R2" ] && [ "$R2" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    [ -n "$R3" ] && [ "$R3" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    [ -n "$R5" ] && [ "$R5" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    if [ "$NON_EMPTY" -eq 3 ]; then
        print_result "2.2, 2.3, 2.5 return data" "true" 4
    else
        print_result "2.2, 2.3, 2.5 return data ($NON_EMPTY/3)" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 2 - File not found (0/20 pts)"
fi
echo ""

# ============================================
# STEP 5: Exercise 3 - Right & Full Joins (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 5: Exercise 3 - Right & Full Joins (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/03-right-full-joins.sql"
EX_OUT="$OUTPUT_DIR/ex3.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    QC=$(grep -c "rows\{0,1\})" "$EX_OUT" 2>/dev/null) || QC=0
    if [ "$QC" -ge 5 ]; then
        print_result "All 5 queries present" "true" 4
    else
        print_result "All 5 queries present ($QC found)" "false" 4
    fi

    R1=$(get_row_count "$EX_OUT" 1)
    if [ "${R1:-0}" = "$ALL_DEPTS" ]; then
        print_result "3.1 All departments with doctor counts ($R1 rows)" "true" 4
    else
        print_result "3.1 All departments (got ${R1:-0}, expected $ALL_DEPTS)" "false" 4
    fi

    R5=$(get_row_count "$EX_OUT" 5)
    R5=${R5:-0}
    if [ "$R5" -ge "$COMPLETED_APPTS" ] 2>/dev/null; then
        print_result "3.5 Claims reconciliation ($R5 rows)" "true" 4
    else
        print_result "3.5 Claims reconciliation (got $R5, expected >= $COMPLETED_APPTS)" "false" 4
    fi

    R2=$(get_row_count "$EX_OUT" 2)
    R3=$(get_row_count "$EX_OUT" 3)
    R4=$(get_row_count "$EX_OUT" 4)
    NON_EMPTY=0
    [ -n "$R2" ] && [ "$R2" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    [ -n "$R3" ] && [ "$R3" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    [ -n "$R4" ] && [ "$R4" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    if [ "$NON_EMPTY" -eq 3 ]; then
        print_result "3.2, 3.3, 3.4 return data" "true" 4
    else
        print_result "3.2, 3.3, 3.4 return data ($NON_EMPTY/3)" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 3 - File not found (0/20 pts)"
fi
echo ""

# ============================================
# STEP 6: Exercise 4 - Self Joins (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 6: Exercise 4 - Self Joins (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/04-self-joins.sql"
EX_OUT="$OUTPUT_DIR/ex4.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    QC=$(grep -c "rows\{0,1\})" "$EX_OUT" 2>/dev/null) || QC=0
    if [ "$QC" -ge 5 ]; then
        print_result "All 5 queries present" "true" 4
    else
        print_result "All 5 queries present ($QC found)" "false" 4
    fi

    R1=$(get_row_count "$EX_OUT" 1)
    if [ "${R1:-0}" = "$ALL_DOCTORS" ]; then
        print_result "4.1 Doctor-supervisor pairs ($R1 rows)" "true" 4
    else
        print_result "4.1 Doctor-supervisor pairs (got ${R1:-0}, expected $ALL_DOCTORS)" "false" 4
    fi

    R2=$(get_row_count "$EX_OUT" 2)
    if [ "${R2:-0}" = "$ALL_DOCTORS" ]; then
        print_result "4.2 Multi-level hierarchy ($R2 rows)" "true" 4
    else
        print_result "4.2 Multi-level hierarchy (got ${R2:-0}, expected $ALL_DOCTORS)" "false" 4
    fi

    R3=$(get_row_count "$EX_OUT" 3)
    if [ "${R3:-0}" = "$ACTIVE_DOCTORS" ]; then
        print_result "4.3 Direct report counts ($R3 rows)" "true" 4
    else
        print_result "4.3 Direct report counts (got ${R3:-0}, expected $ACTIVE_DOCTORS)" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 4 - File not found (0/20 pts)"
fi
echo ""

# ============================================
# STEP 7: Exercise 5 - Multi-Table Joins (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 7: Exercise 5 - Multi-Table Joins (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/05-multi-table-joins.sql"
EX_OUT="$OUTPUT_DIR/ex5.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    QC=$(grep -c "rows\{0,1\})" "$EX_OUT" 2>/dev/null) || QC=0
    if [ "$QC" -ge 5 ]; then
        print_result "All 5 queries present" "true" 4
    else
        print_result "All 5 queries present ($QC found)" "false" 4
    fi

    R1=$(get_row_count "$EX_OUT" 1)
    if [ "${R1:-0}" = "50" ]; then
        print_result "5.1 Patient visit report (LIMIT 50)" "true" 4
    else
        print_result "5.1 Patient visit report (got ${R1:-0}, expected 50)" "false" 4
    fi

    R2=$(get_row_count "$EX_OUT" 2)
    if [ "${R2:-0}" = "$ACTIVE_DOCTORS" ]; then
        print_result "5.2 Doctor productivity ($R2 rows)" "true" 4
    else
        print_result "5.2 Doctor productivity (got ${R2:-0}, expected $ACTIVE_DOCTORS)" "false" 4
    fi

    R3=$(get_row_count "$EX_OUT" 3)
    if [ "${R3:-0}" = "$ALL_PROVIDERS" ]; then
        print_result "5.3 Insurance claims analysis ($R3 rows)" "true" 4
    else
        print_result "5.3 Insurance claims analysis (got ${R3:-0}, expected $ALL_PROVIDERS)" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 5 - File not found (0/20 pts)"
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
